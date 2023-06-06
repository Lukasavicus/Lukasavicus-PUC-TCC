# --- SETUP --------------------------------------------------------------------
import requests
from bs4 import BeautifulSoup as bs
import io
import os
import hashlib
import json
from datetime import datetime
import boto3
import tempfile
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

BUCKET_NAME = os.environ["BUCKET_NAME"]
PREFIX_PATH = os.environ["PREFIX_PATH"] # '.'
CONFIG_FILE = os.environ["CONFIG_FILE"]
SOURCE = str(os.environ["SOURCE"])
_s3 = boto3.client('s3')

# --- SPECIFIC FUNCTIONS -------------------------------------------------------
# --- LOCAL FILE STORAGE -------------------------------------------------------
# def read_file(filename):
#   try:
#     with open(filename) as f:
#       data = json.load(f)
#     return data
#   except Exception as e:
#     raise e

# def write_file(content, filename, mode='wb'):
#   with open(filename, mode) as f:
#           f.write(content)

# def dump_json(content, filename):
#   with open(filename, 'w') as outfile:
#     json.dump(content, outfile)

# def listdir(folder):
#     return os.listdir(folder)

# --- S3 AS FILE STORAGE -------------------------------------------------------
def read_file(filename):
  resp = _s3.get_object(Bucket=BUCKET_NAME, Key=filename)
  content = resp['Body'].read()#.decode('utf-8')
  return content

def write_file(content:str, filename, mode='wb'):
    print("Writing ", filename)
    print("content ", content)
    _s3r = boto3.resource('s3')
    s3object = _s3r.Object(BUCKET_NAME, filename)
    resp = s3object.put( Body=(bytes(content) ))
    print('resp', resp)

def dump_json(content, filename):
    _s3r = boto3.resource('s3')
    s3object = _s3r.Object(BUCKET_NAME, filename)

    s3object.put(
        Body=(bytes(json.dumps(content).encode('UTF-8')))
    )

def listdir(folder):
    _s3r = boto3.resource('s3')
    s3_bckt = _s3r.Bucket(BUCKET_NAME)

    objs = [object_summary.key for object_summary in s3_bckt.objects.filter(Prefix=f"{folder}/")]
    return objs

def create_temp_file_from_str(s):
  tmp = tempfile.NamedTemporaryFile()
  
  # Open the file for writing.
  with open(tmp.name, 'w') as f:
      f.write(s) # where `stuff` is, y'know... stuff to write (a string)


# --- FUNCTIONS ----------------------------------------------------------------
def gen_file_hash(file_location_or_file_pointer, mode='buffered', buffer_size=65536, method='md5'):
  methods=['md5', 'sha1']
  if(method not in methods):
    raise Exception("Unrecognize hashing method")
  else:
    if(method == 'md5'):
      method_obj = hashlib.md5()
    elif(method == 'sha1'):
      method_obj = hashlib.sha1()
  if(isinstance(file_location_or_file_pointer, str)):
    if(mode == "buffered"):
      with open(file_location_or_file_pointer, 'rb') as f:
          while True:
              data = f.read(buffer_size)
              if not data:
                  break
              method_obj.update(data)
    else:
      data = read_file(file_location_or_file_pointer)
      method_obj.update(data)
  elif(isinstance(file_location_or_file_pointer, io.TextIOWrapper)):
    raise Exception("Not implemented yet")
  return method_obj.hexdigest()
  
def download_files(base_folder):
  """
    download_files:
    -------
    Download all data files defined by the base_url and saves them into a folder.
  """
  # --- 1. get initial data's website page --------------------------
  base_url = "https://dados.mg.gov.br/dataset/despesa"
  r = requests.get(base_url, verify=False)
  page = bs(r.text, features="html.parser")

  # --- 2. get resources from initial page --------------------------
  items = page.find_all('li', {'class' : 'resource-item'})
  ids = [item['data-id'] for item in items]
  links = [f"https://dados.mg.gov.br/dataset/despesa/resource/{i}" for i in ids]

  # --- 3. For every resource: get resource download link -----------
  resources_links = []
  errs_links = []
  for link in links:
    try:
      resource_page = requests.get(link)
      resource_link = bs(resource_page.text, features="html.parser")
      href = resource_link.find('a', {'class' : "resource-url-analytics"}).attrs['href']
      resources_links.append(href)
    except Exception as e:
      errs_links.append({'resource' : link,  'err' : e})

  # --- 4. Do the downloads -----------------------------------------
  now_str = datetime.now().strftime("%Y-%m-%d-%H:%M:%S")
  errs_gz = []
  resources = []
  for rl in resources_links:
      filename = rl.split('/')[-1].split('.')[0] + ".csv.gz"
      complete_filename = os.path.join(base_folder, filename)
      try:
        r = requests.get(rl)
        write_file(r.content, complete_filename, 'wb')
        resources.append({
            'filename': complete_filename,
            'link' : link,
            'accessed_in' : now_str
        })
      except Exception as e:
        errs_gz.append({'filename' : filename, 'link' : rl, 'err' : e})
  
  return (resources, errs_links, errs_gz)
  
def create_hashcache_file_from_folder(base_folder, original_source=[]):
  print('create_hashcache_file_from_folder', base_folder, original_source, len(original_source))
  now_str = datetime.now().strftime("%Y-%m-%d-%H:%M:%S")
  resources_hashs = []
  if(len(original_source) == 0):
    for f in listdir(base_folder):
      if(f.endswith('.csv.gz')):
        h = gen_file_hash(f, mode="plain")
        resources_hashs.append({'resource' : f, 'link' : None, 'hash' : h, 'accessed_in' : None, 'updated_in' : now_str})
  else:
    for s in original_source:
      print('s', s)
      h = gen_file_hash(s['filename'], mode="plain")
      resources_hashs.append({'resource' : s['filename'], 'link' : s['link'], 'hash' : h, 'accessed_in' : s['accessed_in'], 'updated_in' : now_str})
  
  # with open('hashcache.json', 'w') as outfile:
  #   json.dump(resources_hashs, outfile)
  filename = f"{PREFIX_PATH}/hashcache.json"
  dump_json(resources_hashs, filename)
  # return resources_hashs
    
def create_hashcache_file(source="site", base_folder=""):
  """
    source parameter defines which will be the source of the hash cache file.
    It might be:
      - 'site': Pass this option if you think that the file folder is corrupted or incomplete;
      - 'folder': If the hashcache file was delete or was corrupted, but you still have all files stored in a folder, use this option.
  """
  print(source, 'site', source=='site', str(source) == 'site')
  if(source == 'site'):
    resources, _, _ = download_files(base_folder)
    create_hashcache_file_from_folder(base_folder, resources)
  elif(source == 'folder'):
    create_hashcache_file_from_folder(base_folder)
  else:
    raise Exception(f"Parameter 'source' expected either 'site' or 'folder', but '{source}' was passed.")

def read_hashcache_file(hc_path:str):
    """
        hc_path: hashcache file path
    """
    create_hashcache_file(source=SOURCE, base_folder=PREFIX_PATH)
    # try:
    #     f = read_file(hc_path)
    # # except FileNotFoundError as e:
    # except Exception as e:
    #     print("Exception e", e)
    #     print("creating a hashcache file")
    #     create_hashcache_file(source=SOURCE, base_folder=PREFIX_PATH)
        # print("hashcache file created succesfully")
        # f = read_file(hc_path)
    # return f

def lambda_handler(event, context):
    hc_path = os.path.join(PREFIX_PATH, 'hashcache.json')
    hc = read_hashcache_file(hc_path)
    print(hc)

# def lambda_handler(event, context):
#     # TODO implement
#     print("event", event)
#     print("context", context)
#     return {
#         'statusCode': 200,
#         'body': json.dumps('Hello from Lambda!')
#     }