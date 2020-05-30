FROM ubuntu:18.04

MAINTAINER <christoph.hahn@uni-graz.at>

RUN apt-get update && \
	apt-get install -y build-essential=12.4ubuntu1 \
		vim git wget unzip language-pack-en \
		perl=5.26.1-6ubuntu0.3 python3=3.6.7-1~18.04 python3-pip=9.0.1-2.3~ubuntu1.18.04.1 \
		exonerate=2.4.0-3 hmmer=3.1b2+dfsg-5ubuntu1 ncbi-blast+=2.6.0-1

#Add blast executables to location expected by RepeatModeler
RUN for f in $(find /usr/bin/ -name '*blast*'); do ln -s $f /usr/local/bin/; done

#Set language
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8 

