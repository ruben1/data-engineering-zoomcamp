FROM python:3.9 AS base

RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY ingest_data.py pipeline.py

ENTRYPOINT ["python", "pipeline.py"]