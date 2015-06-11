for bw in 48 32 16 8; do
  (cd 96000 && echo "Making ${bw}kHz files" && mkdir -p ../${bw}000/ &&
    for file in *.wav; do
      sox $file -c 1 -r ${bw}000 ../${bw}000/$file;
    done
  );
done
# To build the native Debian package, simply run   dch -i   then   dpkg-buildpackage
