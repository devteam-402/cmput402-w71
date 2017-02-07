FROM python:2.7.13

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt ./
RUN pip install -r requirements.txt

RUN apt-get -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q netcat
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-client
