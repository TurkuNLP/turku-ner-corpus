This README briefly documents the realignment of the corpus NER
annotations to the Universal Dependencies v2.5 version of the Turku
Dependency Treebank data. This may be helpful if there's a need to
align again to a newer version, but otherwise just documentary.

Split data into one .conllu file per document

```
for s in train dev test; do
    d=data/tdt-conllu/$s
    (
	mkdir -p $d
	cd $d
	python3 ../../../scripts/split_by_document.py \
	  ../../UD_Finnish-TDT/fi_tdt-ud-${s}.conllu
    )
done
```

Convert into standoff

```
for s in train dev test; do
    d=data/tdt-standoff/${s};
    (
	mkdir -p $d
	cd $d
	for f in ../../tdt-conllu/$s/*.conllu; do
	    python3 ../../../scripts/ud_to_standoff.py $f
	done
    )
done
```

Check text differences

```
for f in data/standoff/*/*.txt; do
    diff $f ${f/standoff/tdt-standoff}
done
```

Clone alignment tool

```
git clone https://github.com/spyysalo/annalign.git
```

Align standoff to new text

```
for s in train dev test; do
    d=data/realigned-standoff/$s
    mkdir -p $d
    for f in data/standoff/$s/*.ann; do
        python3 annalign/annalign.py $f ${f%.ann}.txt \
	    data/tdt-standoff/$s/$(basename $f .ann).txt > $d/$(basename $f)
    done
done
```

Check standoff differences

```
for f in data/standoff/*/*.ann; do
    diff $f ${f/standoff/realigned-standoff}
done
```

Check standoff differences other than offsets

```
for f in data/standoff/*/*.ann; do
    diff <(perl -pe 's/ \d+ \d+//' $f) \
         <(perl -pe 's/ \d+ \d+//' ${f/standoff/realigned-standoff})
done
```

Copy over old versions

```
for s in train dev test; do
    cp data/tdt-standoff/$s/*.txt data/realigned-standoff/$s/*.ann \
        data/standoff/$s
done
```

Regenerate CoNLL versions

```
./scripts/convert-to-conll.sh
```

Check

```
git diff data/conll
```

(Changed 11 tokens and 4 annotations.)

Modify `scripts/convert-to-conll.sh` to replicate document order from
UD data

