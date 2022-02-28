FROM chrishah/ubuntu-basic:18

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

#install SNAP
RUN git clone --recursive https://github.com/KorfLab/SNAP.git && \
	cd SNAP && \
	git reset --hard a89d68e8346337c155b99697389144dfb5470b0f && \
	make && \
	cd ..
ENV ZOE="/usr/src/SNAP/Zoe"

# install Augustus (the version shipping with ubuntu 18 is 3.3, but had problems with this so I replace it with version 3.3.2 which can be downloaded as executable from Github)
RUN apt install -y \
	augustus=3.3+dfsg-2build1 augustus-data=3.3+dfsg-2build1 augustus-doc=3.3+dfsg-2build1 libyaml-perl=1.24-1 \
	rsync && \
	wget -O /usr/bin/augustus https://github.com/Gaius-Augustus/Augustus/releases/download/3.3.2/augustus
ENV AUGUSTUS_CONFIG_PATH /usr/share/augustus/config
#DBI perl module is necessary for autoAug
ENV PERL_MM_USE_DEFAULT=1
RUN cpan DBI
#set up scipio
RUN git clone https://github.com/chrishah/maker-docker.git && \
	cd maker-docker && \
	git reset --hard af68b54e7330b531eb9c53a5a7774c740ed08e85 && \
	cp ab-initio/to_include/scipio-1.4.zip /usr/src/ && \
	cd /usr/src && \
	rm -rf maker-docker && \
	unzip scipio-1.4.zip && \
	rm scipio-1.4.zip && \
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

#install perl modules required for Genemark
RUN cpan YAML && \
        cpan Hash::Merge && \
        cpan Logger::Simple && \
        cpan Parallel::ForkManager && \
	cpan MCE::Mutex && \
	mkdir /usr/local/Genemark

#add the (at this point empty) Genemark directory to the path in anticipation
ENV PATH="/usr/local/Genemark:${PATH}"
