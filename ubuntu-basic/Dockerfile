FROM ubuntu:18.04

MAINTAINER <christoph.hahn@uni-graz.at>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential vim git wget unzip language-pack-en \
		python3 python3-pip \
		exonerate hmmer ncbi-blast+=2.6.0-1

#Add blast executables to location expected by RepeatModeler
RUN for f in $(find /usr/bin/ -name '*blast*'); do ln -s $f /usr/local/bin/; done

#Set language
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8 

