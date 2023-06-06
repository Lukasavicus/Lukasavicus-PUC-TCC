import pandas as pd
import awswrangler as wr

import boto3
boto3.setup_default_session(aws_access_key_id="AKIAWRMSL6QV2RJ7IU5J", aws_secret_access_key="...", region_name="us-east-1")

def set_data_table(df, table_name):
    database = 'dep-puc'
    path = f's3://dpe-us-east-1-s3/silver-layer/advanced_analysis/{table_name}/'
    complete_path = f'{path}{table_name}.csv'

    type_mapping = {
        'int64' : 'int',
        'object' : 'string',
        'float64' : 'float'
    }

    wr.s3.to_csv(
        df,
        complete_path,
        index=False
    )

    columns_types = {}
    for c in df.columns:
        try:
            columns_types[c] = type_mapping[str(df[c].dtype)]
        except Exception as e:
            columns_types[c] = 'string'

    print('columns_types', columns_types)
    wr.catalog.create_csv_table(
        database=database,
        path=path, 
        table=table_name,
        columns_types=columns_types,
        mode='overwrite',
        skip_header_line_count=1,
        sep=','
    )