FROM chrishah/repeatmasker-maker:18

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

#install perl modules required for maker
ENV PERL_MM_USE_DEFAULT=1
RUN cpan DBI && \
	cpan DBD::SQLite && \
	cpan forks && \
	cpan forks::shared && \
	cpan File::Which && \
	cpan Perl::Unsafe::Signals && \
	cpan Bit::Vector && \
	cpan Inline::C && \
	cpan IO::All && \
	cpan IO::Prompt

#set up minimal bioperl
RUN wget https://github.com/bioperl/bioperl-live/archive/release-1-7-2.tar.gz && \
	tar xvfz release-1-7-2.tar.gz
ENV PERL5LIB="/usr/src/bioperl-live-release-1-7-2"

#install SNAP
#RUN git clone --recursive https://github.com/KorfLab/SNAP.git && \
#	cd SNAP && \
#	git reset --soft a89d68e8346337c155b99697389144dfb5470b0f && \
#	make && \
#	cd ..
#ENV ZOE="/usr/src/SNAP/Zoe"
#ENV PATH="/usr/src/SNAP:${PATH}"

# install Augustus
#RUN apt install -y augustus augustus-data augustus-doc
#ENV AUGUSTUS_CONFIG_PATH /usr/share/augustus/config

#install Repeatmasker (much of this was taken and slighly modified from robsyme/repeatmasker-onbuild)
# Install TRF (for RepeatScout)
#WORKDIR /usr/local/bin
#RUN wget http://tandem.bu.edu/trf/downloads/trf407b.linux64 && mv trf*.linux64 trf && chmod +x trf

# Install nseg (for RepeatScout)
#RUN mkdir nseg && \
#    cd nseg && \
#    wget ftp://ftp.ncbi.nih.gov/pub/seg/nseg/* && \
#    make && \
#    mv nseg ../bin && \
#    mv nmerge ../bin

# Install RepeatScout
#RUN wget http://bix.ucsd.edu/repeatscout/RepeatScout-1.0.5.tar.gz && \
#    tar -xvf RepeatScout* && \
#    rm RepeatScout*.tar.gz && \
#    mv RepeatScout* RepeatScout && \
#    cd RepeatScout && \
#    make	

# Install RMBlast (Repeatmasker expects makeblastdb and blastx in the same location as rmblastn)
#RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/2.2.28/ncbi-rmblastn-2.2.28-x64-linux.tar.gz && \
#    tar -xzvf ncbi-rmblastn* && \
#    rm ncbi-rmblastn*.tar.gz && \
#    mv ncbi-rmblastn*/bin/rmblastn /usr/local/bin && \
#    rm -rf ncbi-rmblastn* && \
#    cp /usr/bin/makeblastdb /usr/bin/blastx /usr/local/bin

## Install Blast+
##RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-x64-linux.tar.gz && \
##    tar -xzvf ncbi-blast* && \
##    find ncbi-blast* -type f -executable -exec mv {} bin \; && \  
##    rm -rf ncbi-blast*
    
# Install RepeatMasker
#RUN wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz \
#    && tar -xzvf RepeatMasker-open*.tar.gz \
#	&& rm -f RepeatMasker-open*.tar.gz \
#	&& perl -0p -e 's/\/usr\/local\/hmmer/\/usr\/bin/g;' \
#	-e 's/\/usr\/local\/rmblast/\/usr\/local\/bin/g;' \
#    -e 's/DEFAULT_SEARCH_ENGINE = "crossmatch"/DEFAULT_SEARCH_ENGINE = "ncbi"/g;' \
#    -e 's/TRF_PRGM = ""/TRF_PRGM = "\/usr\/local\/bin\/trf"/g;' RepeatMasker/RepeatMaskerConfig.tmpl > RepeatMasker/RepeatMaskerConfig.pm

#Install Repeatmasker dependency perl module
#RUN cpan Text::Soundex

# Fix RepeatMasker's strange shebang lines
#RUN cd /usr/local/bin/RepeatMasker \
#	&& perl -i -0pe 's/^#\!.*perl.*/#\!\/usr\/bin\/env perl/g' \
#	RepeatMasker \
#    DateRepeats \
#    ProcessRepeats \
#    RepeatProteinMask \
#    DupMasker \
#    util/queryRepeatDatabase.pl \
#    util/queryTaxonomyDatabase.pl \
#    util/rmOutToGFF3.pl \
#    util/rmToUCSCTables.pl

#./rebuild contains code for rebuilding the Repbase Master library that I have extracted from the main RepeatMasker script, normally this is done when running RepeatMasker
#for the first time, but MAKER complains, so I build it first
#ADD to_include/rebuild /usr/local/bin/RepeatMasker

# Install RIPcal (not sure if this is actually needed for maker)
##RUN wget http://downloads.sourceforge.net/project/ripcal/RIPCAL/RIPCAL_2.0/ripcal2_install.zip \
##	&& unzip ripcal*.zip \
##	&& rm ripcal*.zip \
##	&& mv ripcal* ripcal \
##	&& cd ripcal \
##	&& chmod +x perl/*

# Install RECON (not sure if this is actually needed for maker)
##RUN wget http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz \
##	&& tar -xvf RECON* \
##	&& rm RECON*.tar.gz \
##	&& mv RECON* recon \
##	&& cd recon/src \
##	&& make \
##	&& make install \
##	&& perl -i -0pe 's/\$path = "";/\$path = "\/usr\/local\/RECON-1.08\/bin";/g' ../scripts/\recon.pl

# Install RepeatModeler deps (not sure if this is actually needed for maker)
#RUN apt-get install -qqy libjson-perl liburi-perl liblwp-useragent-determined-perl

# Install RepeatModeler (not sure this is actually needed for maker)
#RUN wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-open-1.0.10.tar.gz \
#	&& tar -xvf RepeatModeler-*.tar.gz \
#	&& rm RepeatModeler-*.tar.gz \
#	&& mv RepeatModeler-*/ RepeatModeler \
#	&& cd RepeatModeler \
#	&& perl -i -0pe 's/^#\!.*/#\!\/usr\/bin\/env perl/g' \
#	configure \
#	BuildDatabase \
#	Refiner \
#	RepeatClassifier \
#	RepeatModeler \
#	TRFMask \
#	util/dfamConsensusTool.pl \
#	util/renameIds.pl \
#	util/viewMSA.pl \
#	&& cat RepModelConfig.pm.tmpl \
#	| perl -p -e 's/\$RMBLAST_DIR +=.*;$/\$RMBLAST_DIR = "\/usr\/local\/bin";/g' \
#	| perl -p -e 's/\$RECON_DIR +=.*;$/\$RECON_DIR = "\/usr\/local\/recon\/bin";/g' \
#	| perl -p -e 's/\$RSCOUT_DIR +=.*;$/\$RSCOUT_DIR = "\/usr\/local\/bin\/RepeatScout";/g' \
#	> RepModelConfig.pm

#Set PATH
#ENV PATH="/usr/local/bin/RepeatMasker:/usr/local/bin/RepeatMasker/util:/usr/local/bin/RepeatScout:/usr/local/bin/recon/bin:/usr/local/bin/RepeatModeler:${PATH}"

ONBUILD WORKDIR /usr/local/bin/RepeatMasker

#Add the Repeatmasker Repbase libraries
ONBUILD ADD repeatmaskerlibraries.tar.gz /usr/local/bin/RepeatMasker

#The next bit fixes a problem that I have seen when the repeat metadata that ships with Repeatmasker
#does not match with the embl file that contains the sequences
#The last command in this block rebuilds the Master library (./rebuild contains code for this that I have extracted from the main RepeatMasker script)
ONBUILD RUN echo "Checking Repbase metadata against sequence data" >&2 && \
        cat Libraries/RMRBSeqs.embl | grep "^ID " | sed 's/^ID   //' | cut -d " " -f 1 | sort -n | uniq | perl -ne 'chomp; print "$_\n$_\n"' > comp1 && \
        cat Libraries/RMRBMeta.embl | grep "^ID " | sed 's/^ID   //' | cut -d " " -f 1 | sort -n | uniq > comp2 && \
        cat comp1 comp2 | sort -n | uniq -c | grep "   1 " | sed 's/^ .*1 //' > missing && \
        for m in $(cat missing); do sed -i "/$m/,/\/\//d" Libraries/RMRBMeta.embl; done && \
        rm comp1 comp2 missing && \
        perl ./rebuild

#This is not necessary anymore - done within ./rebuild above
##ONBUILD RUN cd /usr/local/bin/RepeatMasker && util/buildRMLibFromEMBL.pl Libraries/RMRBSeqs.embl > Libraries/RepeatMasker.lib \
##		&& makeblastdb -dbtype nucl -in Libraries/RepeatMasker.lib > /dev/null 2>&1 \
##	        && makeblastdb -dbtype prot -in Libraries/RepeatPeps.lib > /dev/null 2>&1


#This is an alternative way of ensuring that the Libraries/RepeatMaskerLib.embl Master library is built 
# This is now covered by the rebuild script abovebecause otherwise MAKER complains
# I could also just try to touch a file 'dummy.fasta' 
#Done as part of ./rebuild above
##ONBUILD RUN touch dummy.fasta && \
##	RepeatMasker -engine ncbi -s -pa 1 -sp Homo -noisy -gff dummy.fasta && \
##	rm dummy.fasta

#Building MAKER
ONBUILD WORKDIR /usr/local
ONBUILD ADD maker.tar.gz /usr/local
ONBUILD RUN cd maker/src && \
	perl Build.PL && \
	./Build install

ENV PATH="/usr/local/maker/bin:${PATH}"
	

#WORKDIR /usr/local/bin

# install BUSCO and set the default in the scripts to python3 so I don't have to type it each time
# and full path each time when called
#RUN git clone --recursive https://gitlab.com/ezlab/busco.git && \
#	cd busco && \
#	git reset --soft 3927d240 && \
#	python3 setup.py install && cd .. && \
#	sed -i 's?/usr/bin/env python?/usr/bin/env python3?' /usr/local/bin/busco/scripts/generate_plot.py && \
#	sed -i 's?/usr/bin/env python?/usr/bin/env python3?' /usr/local/bin/busco/scripts/run_BUSCO.py && \
#	ln -s /usr/local/bin/busco/scripts/*.py /usr/bin/
##	echo 'alias generate_plot.py="python3 /usr/src/busco/scripts/generate_plot.py"' >> ~/.bashrc && \
##	echo 'alias run_BUSCO.py="python3 /usr/src/busco/scripts/run_BUSCO.py"' >> ~/.bashrc
#ADD to_include/config.ini /usr/local/bin/busco/config
#ENV BUSCO_CONFIG_FILE /usr/local/bin/busco/config/config.ini

#Install R (R installation asks for timezone interactively so this needs to be switched off and set before)
#ENV DEBIAN_FRONTEND noninteractive
#ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
# and finally ggplot2 with all dependencies
#RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
#	echo "tzdata tzdata/Zones/Europe select Vienna" >> /tmp/preseed.txt; \
#	debconf-set-selections /tmp/preseed.txt && \
#	apt-get update && \
#	apt-get install -y tzdata r-base && \
#	R --vanilla -e 'install.packages("ggplot2", repos="http://cran.wu.ac.at/")'

#create working directory and move to entrypoint
VOLUME /home/data
WORKDIR /home/data
