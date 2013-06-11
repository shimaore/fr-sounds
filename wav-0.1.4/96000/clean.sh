for f in ???.wav; do
  CLEAN_FILE=`basename $f .wav`-clean.wav
  sox $f $CLEAN_FILE silence 1 1 1 reverse silence 1 1 1 reverse
  mv $CLEAN_FILE $f
done
