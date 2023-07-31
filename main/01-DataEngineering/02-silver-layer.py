import boto3
from io import BytesIO
import gzip
import os

BUCKET_NAME = os.environ["BUCKET_NAME"]
ORIGIN_PREFIX_PATH = os.environ["ORIGIN_PREFIX_PATH"]
DEST_PREFIX_PATH = os.environ["DEST_PREFIX_PATH"]


def listdir(folder):
    _s3r = boto3.resource('s3')
    s3_bckt = _s3r.Bucket(BUCKET_NAME)

    objs = [object_summary.key for object_summary in s3_bckt.objects.filter(Prefix=f"{folder}/")]
    return objs

def unzip_and_save(bucket_orig, file_orig, bucket_dest, file_dest):
    print("Unzip and Save", bucket_orig, file_orig, bucket_dest, file_dest)
    _s3 = boto3.client('s3', use_ssl=False)  # optional
    _s3.upload_fileobj(        
        Fileobj=gzip.GzipFile(None, 'rb',             
            fileobj=BytesIO(_s3.get_object(Bucket=bucket_orig, Key=file_orig)['Body'].read())),
        Bucket=bucket_dest,        
        Key=file_dest) 

def list_to_unzip():
    objects = listdir(ORIGIN_PREFIX_PATH)
    print('objects', objects)
    errs_unzip = []
    for obj in objects:
        try:
            complete_filename = obj.split('/')[1]
            filename = '.'.join(complete_filename.split('.')[:-1])
            if(filename.endswith('.csv')):
                # print(filename)
                unzip_and_save(BUCKET_NAME, f"{ORIGIN_PREFIX_PATH}/{filename}.gz", BUCKET_NAME, f"{DEST_PREFIX_PATH}/{filename}")
                pass
        except Exception as e:
            errs_unzip.append({'file' : obj, 'err' : e})
    
    if(len(errs_unzip)):
        print('errs_unzip', errs_unzip)

def lambda_handler(event, context):
    list_to_unzip()
