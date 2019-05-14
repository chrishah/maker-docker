FROM chrishah/repeatmasker-maker:18

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

#install perl modules required for maker
ENV PERL_MM_USE_DEFAULT=1
RUN cpan DBD::SQLite && \
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
	tar xvfz release-1-7-2.tar.gz && \
	rm release-1-7-2.tar.gz
ENV PERL5LIB="/usr/src/bioperl-live-release-1-7-2"

ONBUILD WORKDIR /usr/local/RepeatMasker

#Add the Repeatmasker Repbase libraries
ONBUILD ADD repeatmaskerlibraries.tar.gz /usr/local/RepeatMasker

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

#Building MAKER
ONBUILD WORKDIR /usr/local
ONBUILD ADD maker.tar.gz /usr/local
ONBUILD RUN cd maker/src && \
	perl Build.PL && \
	./Build install

ENV PATH="/usr/local/maker/bin:${PATH}"
	
#create working directory and move to entrypoint
VOLUME /home/data
WORKDIR /home/data
