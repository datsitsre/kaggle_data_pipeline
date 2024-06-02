import os
from prefect import flow, task, get_run_logger
from kaggle.api.kaggle_api_extended import KaggleApi
import psycopg2
import pandas as pd
import numpy as np





@task
def get_data(username :str, file: str, data_path: str, zip_type: bool, mode: bool, pesist_result=True):
    kaggle_api = KaggleApi()
    kaggle_api.authenticate()
    logger = get_run_logger()
    data_retreieve =  kaggle_api.dataset_download_files(f"{username}/{file}",path=data_path, unzip=zip_type,quiet=mode)
    logger.info(data_retreieve)
    return data_path




@task
def clean_data(import_data: str, path_data: str, persist_result=True):
    ##load the drivers.csv data

 
    def driver_data_clean():
        df = pd.read_csv(f"./{import_data}/drivers_updated.csv") 
        # normalize the column pos
        for data in range(0, len(df)):
            if not isinstance(df.iloc[data,0], int):
                df.iloc[data, 0] = np.random.randint(0, 30)
            
        df.dropna(axis=0,inplace=True)
        df['index'] = np.arange(0, len(df))
        cols = list(df.columns)
        df = df.reindex(columns=cols[-1:]+cols[:-1])
        df.to_csv(f"./{path_data}/drivers.csv", index=False)
        #print(df)
        
    def fast_laps():
        # process fastest laps
        df_fastest_laps = pd.read_csv(f'./{import_data}/fastest_laps_updated.csv',parse_dates=['Time'])
        df_fastest_laps['Time'] = pd.to_datetime(df_fastest_laps['Time'], errors='coerce').dt.time
        df_fastest_laps.dropna(axis=0,inplace=True)
        for data in range(0, len(df_fastest_laps['year'])):
            if not isinstance(df_fastest_laps.iloc[data, 5], int):
                df_fastest_laps.iloc[data, 5] = np.random.randint(1950, 2024)
        
        df_fastest_laps['index'] = np.arange(0, len(df_fastest_laps))
        cols = list(df_fastest_laps.columns)
        df_fastest_laps = df_fastest_laps.reindex(columns=cols[-1:]+cols[:-1])
        df_fastest_laps.to_csv(f'./{path_data}/fast_laps.csv', index=False)
        #print(df_fastest_laps)
    
    def teams_clean():
        # preprocess teams data
        df_teams = pd.read_csv(f'./{import_data}/teams_updated.csv') 
        for data in range(0, len(df_teams['Pos'])):
            if not isinstance(df_teams.iloc[data, 0], int):
                df_teams.iloc[data, 0] = np.random.randint(0, 30)
                
        df_teams['index'] = np.arange(0, len(df_teams))
        cols = list(df_teams.columns)
        df_teams = df_teams.reindex(columns=cols[-1:]+cols[:-1])
        df_teams.to_csv(f'./{path_data}/teams.csv', index=False)
        #print(df_teams)
        
    def winners_clean():
        #pre process data
        df_winners = pd.read_csv(f'./{import_data}/winners.csv')
        df_winners['index'] = np.arange(0, len(df_winners))
        cols = list(df_winners.columns)
        df_winners = df_winners.reindex(columns=cols[-1:]+cols[:-1])
        df_winners.to_csv(f'./{path_data}/winners.csv', index=False)
        #print(df_winners)



    driver_data_clean() 
    fast_laps()
    teams_clean()
    winners_clean()
    
    



    
@flow 
def central_point():
    name = "lakshayjain611"
    file = "f1-races-results-dataset-1950-to-2024"
    local_store = "data"
    zip_data = True
    mode_type = True
    store_data = get_data(name, file, local_store, zip_data, mode_type)
    final_files = "updata"
    clean_data(store_data, final_files)
    



def main():
   # main function that calls data 
   central_point.serve("etl_kaggle_data_project")
    







if __name__ == "__main__":
    main()