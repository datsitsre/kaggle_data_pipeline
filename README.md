
# Kaggle Data Pipeline Project 

The project seeks to build a customize data pipeline to scrape data from Kaggle Api source and ingest the data into a cloud native platform for organizational usage.  The data pipeline leverage on current data orchestration tool (prefect, python), cloud platform (S3, redshift) and infrastructure as a code (terraform)platform forming the core part of this project.
## Acknowledgements

 - [Prefect](https://www.prefect.io/)
 - [AWS S3 COPY](https://docs.aws.amazon.com/redshift/latest/dg/t_loading-tables-from-s3.html)
 - [Redshift check values command](https://sqlhaven.wordpress.com/2014/09/10/common-errors-of-redshift-copy-command-and-how-to-solve-them-part-2/)


## API Reference

#### Get all items

```http
   kaggle_api.dataset_download_files(f"{username}/{file}",path=data_path, unzip=zip_type,quiet=mode)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `username` | `string` | **kaggle username** |



| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `filename` | `string` | **kaggle file store name**. |

#### Get item


•	The Kaggle API normally check the username and secret for each user at ~/.Kaggle/

•	Also, the environment variables for Kaggle were exported inside the. env or. \Script\activate 


## Authors

- [@datsitsre](https://github.com/datsitsre/kaggle_data_pipeline.git)


## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Deployment

To deploy this project run

```bash
o	Python3 -m venv  . 
o	Source ./bin/activate
o	./Script/ activate
o	pip install -r requirement
o	prefect server start
o	python3 main.py
o	Terraform init 
o	Terraform plan 
o	Terraform apply

Optional 
- docker-compose up -d



## Environment Variables

To run this project, you will need to add the following environment variables to your .env file
`KAGGLE_USERNAME`
`KAGGLE_KEY`
`AWS_ACCESS_KEY_ID`
`AWS_SECRET_ACCESS_KEY`


## 🚀 About Me
I'm a Daniel Atsitsre a azure data engineering and scientist with a key eye for achieving organizational goals. With over 2 years worth of experience i believe am capable and willing to collabrate and work to achieve layed down goals.


![Logo](https://excalidraw.com/#json=iW9CiIpFeLGTXb8Pfsnus,BD3x5SSB5WwKsM9iQDhEUA)


## Tech Stack

**Client:** Kaggle 

**Server:**  Prefect


## Run Locally

Clone the project

```bash
  git clone https://github.com/datsitsre/kaggle_data_pipeline.git
```

Go to the project directory

```bash
  cd kaggle_data_pipeline
```

Install dependencies

```bash
  pip install -r requirment
```

Start the server

```bash
  prefect  server start
```

 Run the code
 ```bash
 python3 main.py
