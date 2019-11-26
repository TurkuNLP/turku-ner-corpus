#!/bin/bash

# Split standoff data into subdirectories by source

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
INDIR="$DIR/../data/standoff"
OUTDIR="$DIR/../data/standoff-split"

for d in train dev test; do
    for s in b e f h j s t u w wn; do
	case $s in
	    b) n=blog-entry;;
	    e) n=europarl-speech;;
	    f) n=fiction;;
	    h) n=grammar-example;;
	    j) n=jrcacquis-legal;;
	    s) n=student-magazine;;
	    t) n=financial-news;;
	    u) n=university-news;;
	    w) n=wikipedia;;
	    wn) n=wiki-news;;
	esac
	mkdir -p "$OUTDIR/$n/$d"
	cp "$INDIR/$d/$s"[^a-z]*.{txt,ann} "$OUTDIR/$n/$d"
    done
done
