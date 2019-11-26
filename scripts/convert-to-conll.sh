#!/bin/bash

# Convert data from standoff into CoNLL-like format

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
set -euo pipefail

INDIR="$DIR/../data/standoff"
OUTDIR="$DIR/../data/conll"
TOOLDIR="$DIR/../tools"

mkdir -p "$OUTDIR"

mkdir -p "$TOOLDIR"
if [ -e "$TOOLDIR/standoff2conll" ]; then
    echo "$TOOLDIR/standoff2conll exists, not cloning again"
else
    cd "$TOOLDIR"
    git clone https://github.com/spyysalo/standoff2conll.git
    cd standoff2conll
    git checkout f9bd333 2>/dev/null    # Make sure we have the right version
fi

for s in train dev test; do
    python3 "$TOOLDIR/standoff2conll/standoff2conll.py" \
	    --tokenization space \
	    --no-sentence-split \
	    "$INDIR/$s" \
	    > "$OUTDIR/$s.tsv"
done

SPLITIN="$DIR/../data/standoff-split"
SPLITOUT="DIR/../data/conll-split"

if [ ! -e "$SPLITIN" ]; then
    echo "$SPLITIN does not exist, not converting split"
    exit 1
fi

for t in "$SPLITIN"/*; do
    b=$(basename "$t")
    mkdir -p "$SPLITOUT/$b"
    for s in train dev test; do	
	python3 "$TOOLDIR/standoff2conll/standoff2conll.py" \
		--tokenization space \
		--no-sentence-split \
		"$SPLITIN/$b/$s" \
		> "$SPLITOUT/$b/$s.tsv"
    done
done
