FROM python:3.10-slim-buster

# Install Postgres and configure a username + password
USER root

ARG DB_USERNAME=$DB_USERNAME
ARG DB_PASSWORD=$DB_PASSWORD

# ENV DB_USERNAME=$DB_USERNAME
# ENV DB_PASSWORD=$DB_PASSWORD


RUN apt update -y && apt install postgresql postgresql-contrib -y

WORKDIR /src

COPY ./requirements.txt requirements.txt

# Dependencies are installed during build time in the container itself so we don't have OS mismatch
RUN pip install -r requirements.txt

COPY . .

# Start the database and Flask application
CMD service postgresql start && python app.py
