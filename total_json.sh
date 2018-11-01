#! /bin/sh

dir=JSON/
ext=.json
if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename $0) <json> [-f]"
  exit 1
fi
outfile="$1"

if [ "$2" != "-f" ] && [ -f "$outfile" ]; then
  echo "Output JSON file already exists, skipping"
  exit 1
fi

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
