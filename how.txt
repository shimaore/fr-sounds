VERSION=0.1.4
(cd wav-$VERSION && . how.txt)

(perl map.pl map.txt)

for rate in 8000 16000 32000 48000; do
  echo "Building files for rate=$rate"
  find fr -wholename "fr/*/${rate}/*.wav" > list.txt
  echo 'fr/fr/sibylle/README'    >> list.txt
  echo 'fr/fr/sibylle/COPYRIGHT' >> list.txt
  tar czf freeswitch-sounds-fr-fr-sibylle-${rate}-${VERSION}.tar.gz -T list.txt --mode 0644 --owner root --group root -h
  rm list.txt
done

rsync -a fr/fr/sibylle/ usr/share/freeswitch/sounds/fr/fr/sibylle/
