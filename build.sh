#!/bin/sh
TARGET=fr/fr/sibylle
VERSION=`jq -r .version package.json`
(cd wav/ && ./build.sh)

perl map.pl wav map.txt map2.txt

cp README COPYRIGHT ${TARGET}
for rate in 8000 16000 32000 48000; do
  echo "Building files for rate=$rate"
  find fr -wholename "fr/*/${rate}/*.wav" > list.txt
  echo "${TARGET}/README"    >> list.txt
  echo "${TARGET}/COPYRIGHT" >> list.txt
  tar czf freeswitch-sounds-fr-fr-sibylle-${rate}-${VERSION}.tar.gz -T list.txt --mode 0644 --owner root --group root -h
  rm list.txt
done

# rsync -a fr/fr/sibylle/ usr/share/freeswitch/sounds/fr/fr/sibylle/
