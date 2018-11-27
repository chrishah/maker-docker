# maker-docker

Docker image as base for building full [MAKER](http://www.yandell-lab.org/software/maker.html) image, plus dependencies and third party software

In detail, the image is set up with:
 - Ubuntu 18.04
 - perl 5.26.1
 - Python 3.6.6
 - blast 2.6.0+
 - hmmer 3.1b2
 - Augustus 3.3
 - [BUSCO](https://busco.ezlab.org/) 3.0.2
 - R 3.4.4
   - ggplot2 3.1.0
 - exonerate 2.4.0
 - SNAP (2017-05-17 - git commit: a89d68e8346337c155b99697389144dfb5470b0f)
 - RMBlastn 2.2.28
 - trf 407b
 - RepeatScout 1.0.5
 - RepeatMasker 4.0.7
 - RepeatModeler 1.0.10
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
docker build --network=host -t chrishah/premaker-plus:18 --file .
cd ..
```


__Build the fully functioning MAKER image__

You'll need two more things in your working directory:
 - A copy of the latest [Repbase-derived RepeatMasker libraries](https://www.girinst.org/server/RepBase/index.php), renamed to `repeatmaskerlibraries.tar.gz`
   - this requires free (for academic purposes) registration
   - once registered, download the latest version, e.g. via:
```bash
wget --user your-user-name \
    --password your-password \
    -O repeatmaskerlibraries.tar.gz \
    https://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20181026.tar.gz
```
 - a copy of the MAKER archive (renamed to `maker.tar.gz`)
   - this again requires free (for academic purposes) registration

Once you have all this you can create a Dockerfile,
```bash
echo -e "FROM chrishah/premaker-plus:18" > Dockerfile-maker-plus
```

and build the functioning MAKER image:
```bash
docker build --network=host -t your-maker-plus --file Dockerfile-maker-plus .
```

Or you can use the Dockerfile `premaker-plus/Dockerfile_maker_onbuild` (which is exactly the above), to build the functioning MAKER image via:
```bash
docker build --network=host -t your-maker-plus:version --file dockerfiles/Dockerfile-maker-plus-onbuild .
```

The above was tested with with:
 - MAKER v2.31.10
 - MAKER v3.01.02-beta
 - Repbase Repeatmasker Edition 20181026
