FROM debian:latest

MAINTAINER Sleeck <contact@sleeck.eu>
LABEL description="Tesseract with flasgger"

WORKDIR /data

RUN apt-get update \
	&& export DEBIAN_FRONTEND="noninteractive" \
	&& apt install -y tesseract-ocr tesseract-ocr-* libtesseract-dev python3-pip \
	&& apt clean

ADD requirements.txt /data/requirements.txt
ADD main.py /data/main.py

RUN pip3 install -r /data/requirements.txt

CMD python3 /data/main.py
