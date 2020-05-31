# premaker-plus

The full context of this image can be found [here](https://github.com/chrishah/maker-docker).

Set up Docker image to include external software on-build - this assumes the files `maker.tar.gz` and `repeatmaskerlibraries.tar.gz` to be present in your working directory. 
```bash
docker build -t chrishah/premaker-plus:18-onbuild --file Dockerfile_onbuild .
```
Include external software on-build - 
```bash
docker build -t maker-full:v2.31.10 --file Dockerfile_maker_onbuild .
```
Save the container.
```bash
docker save maker-full:v2.31.10 | gzip > maker-full-v2.31.10.tar.gz
```

Build external software/databases outside the container:
```bash
#Build the container
docker build -t chrishah/premaker-plus:18 --file ./Dockerfile_noonbuild .

#Build Repeatmasker library
docker run --rm -v $(pwd):/in -w /in chrishah/premaker-plus:18 sh ./setup_Repeatmasker.sh src/ external/RepBaseRepeatMaskerEdition-20181026.tar.gz

#Build maker
docker run --rm -v $(pwd):/in -w /in chrishah/premaker-plus:18 sh ./setup_maker.sh src/ external/maker-2.31.10.tgz
```

After this you can run maker like so:
```bash
docker run --rm -v $(pwd):/in -w /in chrishah/premaker-plus:18 ./src/maker/bin/maker -v
```

If you want to include the newly built repeat libraries do this:
```bash
docker run --rm -v $(pwd)/src/RepeatMasker:/usr/local/RepeatMasker -v $(pwd):/in -w /in chrishah/premaker-plus:18 ./src/maker/bin/maker -v
```
If you want to include genemark as well, you can call the container like that (assumes you have a directory `gm_et_linux_64` with all Genemark executables in the `external` directory):
```bash
docker run --rm -v $(pwd)/src/RepeatMasker:/usr/local/RepeatMasker -v $(pwd)/external/gm_et_linux_64/:/usr/local/Genemark -v $(pwd):/in -w /in chrishah/premaker-plus:18 ./src/maker/bin/maker -v
```
