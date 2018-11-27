FROM ubuntu:18.04

MAINTAINER <christoph.hahn@uni-graz.at>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential vim git wget unzip \
	python3 python3-pip \
	exonerate hmmer ncbi-blast+ 

#create working directory and move to entrypoint
VOLUME /home/data
WORKDIR /home/data

