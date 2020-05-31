#!/bin/bash

#use as ./setup_Repeatmasker.sh destination/ external/RepBaseRepeatMaskerEdition-20181026.tar.gz

destination=$1
repeattarball=$2

#take care of RepeatMasker
cp -pfr /usr/local/RepeatMasker $destination
tar xvfz $repeattarball -C $destination/RepeatMasker/
$destination/RepeatMasker/rebuild

