# maker-docker

Docker image ([chrishah/premaker-plus](https://hub.docker.com/r/chrishah/premaker-plus/)) as base for building full [MAKER](http://www.yandell-lab.org/software/maker.html) image, plus dependencies and third party software

FYI, the image builds on a few intermediate images, in the following order:
 - [chrishah/ubuntu-basic](https://hub.docker.com/r/chrishah/ubuntu-basic/)
 - [chrishah/ab-initio](https://hub.docker.com/r/chrishah/ab-initio/)
 - [chrishah/repeatmasker-maker](https://hub.docker.com/r/chrishah/repeatmasker-maker/)

In detail, the [image](https://hub.docker.com/r/chrishah/premaker-plus/) is set up with the following, where the individual tools are build in the intermediate images as listed below (in case you want to use the individually, and don't need the full MAKER context):
 - [chrishah/ubuntu-basic](https://hub.docker.com/r/chrishah/ubuntu-basic/)
   - Ubuntu 18.04
   - perl 5.26.1 
   - Python 3.6.6
   - blast 2.6.0+
   - hmmer 3.1b2
   - exonerate 2.4.0
 - [chrishah/ab-initio](https://hub.docker.com/r/chrishah/ab-initio/)
   - Augustus 3.3
   - [BUSCO](https://busco.ezlab.org/) 3.0.2
   - R 3.4.4
     - ggplot2 3.1.0
   - SNAP (2017-05-17 - git commit: a89d68e8346337c155b99697389144dfb5470b0f)
 - [chrishah/repeatmasker-maker](https://hub.docker.com/r/chrishah/repeatmasker-maker/)
   - RMBlastn 2.2.28
   - trf 407b
   - RepeatScout 1.0.5
   - RepeatMasker 4.0.7
   - RepeatModeler 1.0.10
 - [chrishah/premaker-plus](https://hub.docker.com/r/chrishah/premaker-plus/)
   - perl dependencies for MAKER
     - DBI
     - DBD::SQLite
     - forks
     - forks::shared
     - File::Which
     - Perl::Unsafe::Signals
     - Bit::Vector
     - Inline::C
     - IO::All
     - IO::Prompt

The image can be pulled from Dockerhub (note the tag) via:
```bash
docker pull chrishah/premaker-plus:18
```

or built in the `premaker-plus` directory of this repo, e.g. via:
```bash
cd premaker-plus
docker build --network=host -t chrishah/premaker-plus:18 --file Dockerfile .
cd ..
```

## Build the fully functioning MAKER image

You'll need two more things __in your working directory__:
 - A copy of the latest [Repbase-derived RepeatMasker libraries](https://www.girinst.org/server/RepBase/index.php), renamed to __`repeatmaskerlibraries.tar.gz`__
   - this requires free (for academic purposes) registration
   - once registered, download the latest version, e.g. via:
```bash
wget --user your-user-name \
    --password your-password \
    -O repeatmaskerlibraries.tar.gz \
    https://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20181026.tar.gz
```
 - a copy of the MAKER archive (renamed to __`maker.tar.gz`__)
   - this again requires free (for academic purposes) registration

Once you have all this you can create a Dockerfile,
```bash
echo -e "FROM chrishah/premaker-plus:18" > Dockerfile-maker-plus
```

and build the functioning MAKER image (__be reminded__: you'll need to have the repeatmasker library and the MAKER archive in your working directory):
```bash
docker build --network=host -t your-maker-plus:version --file Dockerfile-maker-plus .
```

Or you can use the Dockerfile `premaker-plus/Dockerfile_maker_onbuild` (which is exactly the above), to build the functioning MAKER image via:
```bash
docker build --network=host -t your-maker-plus:version --file premaker-plus/Dockerfile_maker_onbuild .
```

The above was tested with:
 - MAKER v2.31.10
 - MAKER v3.01.02-beta
 - Repbase Repeatmasker Edition 20181026

## Use the image.. 

like so, to e.g.:
 - run BUSCO: 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version run_BUSCO.py`
 - run RepeatModeler: 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version RepeatModeler`
 - run RepeatMasker: 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version RepeatMasker`
 - run SNAP (fathom): 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version fathom`
 - run augustus: 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version augustus`
 - run MAKER: 
   - `docker run -it -v $(pwd):/in/ -w /in/ --rm your-maker-plus:version maker`


