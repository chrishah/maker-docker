FROM chrishah/ubuntu-basic:18

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

#install SNAP
RUN git clone --recursive https://github.com/KorfLab/SNAP.git && \
	cd SNAP && \
	git reset --soft a89d68e8346337c155b99697389144dfb5470b0f && \
	make && \
	cd ..
ENV ZOE="/usr/src/SNAP/Zoe"

# install Augustus (the version shipping with ubuntu 18 is 3.3, but had problems with this so I replace it with version 3.3.2 which can be downloaded as executable from Github)
RUN apt install -y augustus augustus-data augustus-doc libyaml-perl rsync && \
	wget -O /usr/bin/augustus https://github.com/Gaius-Augustus/Augustus/releases/download/3.3.2/augustus
ENV AUGUSTUS_CONFIG_PATH /usr/share/augustus/config
#DBI perl module is necessary for autoAug
ENV PERL_MM_USE_DEFAULT=1
RUN cpan DBI
#set up scipio
ADD to_include/scipio-1.4.zip /usr/src/
RUN unzip scipio-1.4.zip && \
	ln -s $(pwd)/scipio-1.4/*.pl /usr/bin && \
	ln -s $(pwd)/scipio-1.4/scipio.1.4.1.pl /usr/bin/scipio.pl
#fix path to augustus in scripts and remove check regarding scipio.pl abort in the autoAug pipeline
RUN sed -i 's?augpath = ".*?augpath = "/usr/bin/augustus";?' /usr/share/augustus/scripts/autoAug.pl && \
	sed -i 's/==0 or die("Program aborted. Possibly.*/;/' /usr/share/augustus/scripts/autoAugTrain.pl && \
	sed -i 's?aug="$AUGUSTUS_CONFIG_PATH/../src/augustus?aug="/usr/bin/augustus?' /usr/share/augustus/scripts/autoAugPred.pl
#Download blat
RUN rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/blat/blat /usr/bin/

ENV PATH="/usr/src/SNAP:/usr/share/augustus/scripts:${PATH}"

WORKDIR /usr/local/bin

# install BUSCO and set the default in the scripts to python3 so I don't have to type it each time
# and full path each time when called
RUN git clone --recursive https://gitlab.com/ezlab/busco.git && \
	cd busco && \
	git reset --soft 3927d240 && \
	python3 setup.py install && cd .. && \
	sed -i 's?/usr/bin/env python?/usr/bin/env python3?' /usr/local/bin/busco/scripts/generate_plot.py && \
	sed -i 's?/usr/bin/env python?/usr/bin/env python3?' /usr/local/bin/busco/scripts/run_BUSCO.py && \
	ln -s /usr/local/bin/busco/scripts/*.py /usr/bin/
##	echo 'alias generate_plot.py="python3 /usr/src/busco/scripts/generate_plot.py"' >> ~/.bashrc && \
##	echo 'alias run_BUSCO.py="python3 /usr/src/busco/scripts/run_BUSCO.py"' >> ~/.bashrc
ADD to_include/config.ini /usr/local/bin/busco/config
ENV BUSCO_CONFIG_FILE /usr/local/bin/busco/config/config.ini

#Install R (R installation asks for timezone interactively so this needs to be switched off and set before)
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
# and finally ggplot2 with all dependencies
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
	echo "tzdata tzdata/Zones/Europe select Vienna" >> /tmp/preseed.txt; \
	debconf-set-selections /tmp/preseed.txt && \
	apt-get update && \
	apt-get install -y tzdata r-base && \
	R --vanilla -e 'install.packages("ggplot2", repos="http://cran.wu.ac.at/")'
