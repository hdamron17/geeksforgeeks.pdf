#! /bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $(basename $0) <title>"
  exit 1
fi
title=$1

oldcwd=$(pwd)
cd "$(dirname "$0")"
  sh total_json.sh $title
  python download_total.py TOTAL_JSON/$title.json
  python html_to_pdf.py -f HTML/$title.html
  ( cd PDF; pdfnup --nup 2x2 --suffix '2x2' --no-landscape --frame true --letterpaper $title.pdf )
cd $oldcwd
