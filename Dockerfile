FROM debian:latest

MAINTAINER Sleeck <contact@sleeck.eu>
LABEL description="Tesseract with incron"

WORKDIR /data

RUN apt-get update \
	&& export DEBIAN_FRONTEND="noninteractive" \
	&& apt install -y tesseract-ocr tesseract-ocr-* libtesseract-dev incron

RUN mkdir -p /usr/bin/local/
ADD convert.sh /usr/bin/local/convert.sh
RUN chmod a+x /usr/bin/local/convert.sh
RUN echo "root" > /etc/incron.allow
RUN echo '/data/ IN_CLOSE_WRITE /usr/bin/local/convert.sh $@$#' > /etc/incron.d/convert
CMD /usr/sbin/incrond -n
