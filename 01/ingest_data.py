import os
import pandas as pd
from sqlalchemy import create_engine

def main():
    username = get_env_var("DB_USERNAME")
    password = get_env_var("DB_PASSWORD")
    host = get_env_var("DB_HOST")
    port = get_env_var("DB_PORT")
    db_name = get_env_var("DB_NAME")
    table_name_trip = get_env_var("DB_TABLE_TRIPDATA")
    csv_url_trip = get_env_var("CSV_URL_TRIPDATA")
    table_name_zones = get_env_var("DB_TABLE_ZONES")
    csv_url_zones = get_env_var("CSV_URL_ZONES")

    csv_name_trip = 'tripdata.csv'
    os.system(f"curl {csv_url_trip} -o {csv_name_trip}.gz -L --compressed")
    os.system(f"gzip -d {csv_name_trip}")

    csv_name_zones = 'zones.csv'
    os.system(f"curl {csv_url_zones} -o {csv_name_zones} -L --compressed")

    engine = create_engine(f'postgresql://{username}:{password}@{host}:{port}/{db_name}')
    engine.connect()

    # Trip data
    df = pd.read_csv(csv_name_trip, nrows=100)
    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
    df.head(n=0).to_sql(name=table_name_trip, con=engine, if_exists='replace')
    print(pd.io.sql.get_schema(df, table_name_trip, con=engine))
    df_iter = pd.read_csv(csv_name_trip, iterator=True, chunksize=100000)

    try:
        while True:
            df = next(df_iter)
            df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
            df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
            df.to_sql(name=table_name_trip, con=engine, if_exists='append')
            print("Inserted another chunk")
    except StopIteration:
        print("Finished processing all data")

    # Zones
    df = pd.read_csv(csv_name_zones)
    df.to_sql(name=table_name_zones, con=engine, if_exists='replace')

def get_env_var(envVar):
    value = os.environ[envVar]
    if value == None:
        raise ValueError(f"{envVar} is not set")
    return value

if __name__ == "__main__":
    main()