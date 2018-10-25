#! /bin/sh

dir=JSON/
outdir=TOTAL_JSON/
ext=.json
if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename $0) <title>"
  exit 1
fi
bigtitle="$1"
outfile=$outdir/$bigtitle$ext

oldcwd=$(pwd)
cd "$(dirname "$0")"

mkdir -p $(dirname "$outfile")
echo "{ \"$bigtitle\" : {" > $outfile

for f in $dir*$ext; do
  title="$(basename $f $ext)"
  echo "\"$title\" :" >> $outfile
  cat $f >> $outfile
  echo "," >> $outfile
done
sed '$ s/.$//' $outfile > $outfile.tmp; mv $outfile.tmp $outfile  # remove final comma
echo "} }" >> $outfile

cd $oldcwd
