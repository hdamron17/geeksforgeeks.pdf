#! /bin/sh

if [ "$#" -lt 1 ]; then
  echo "Usage: $(basename $0) <title> [--nup]"
  exit 1
fi
title="$1"
basetitle="$(basename $title .json)"

oldcwd=$(pwd)
cd "$(dirname "$0")"
  sh total_json.sh $title
  python download_total.py $title
  python html_to_pdf.py $title
  if [ "$2" = "--nup" ]; then
    # --nup option applies pdfnup to compress into 2x4
    ( cd PDF; pdfnup --nup 2x2 --suffix '2x2' --no-landscape --frame true --letterpaper $basetitle.pdf )
  fi
cd $oldcwd
