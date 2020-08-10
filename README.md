# Turku NER corpus

An open, broad-coverage corpus for Finnish named entity recognition presented in _[Luoma et al. (2020) A Broad-coverage Corpus for Finnish Named Entity Recognition](https://www.aclweb.org/anthology/2020.lrec-1.567.pdf)_ (PDF).

![Example of Turku NER corpus annotation](https://raw.githubusercontent.com/TurkuNLP/turku-ner-corpus/master/docs/example.png)

## Releases

Version 1.0:

* zip package: [turku-ner-corpus-v1.0.zip](https://github.com/TurkuNLP/turku-ner-corpus/archive/v1.0.zip)
* tgz package: [turku-ner-corpus-v1.0.tar.gz](https://github.com/TurkuNLP/turku-ner-corpus/archive/v1.0.tar.gz)

Recommended. This is the first complete, stable release of the corpus and the version used in our experiments with the data.

## Quickstart

A version of the corpus data is found in CoNLL-like format in the following files:

* `data/conll/train.tsv`: training data
* `data/conll/dev.tsv`: development data
* `data/conll/test.tsv`: test data

These files are in a simple two-column tab-separated format with IOB2 tags:

```
Turun       B-ORG
yliopiston  I-ORG
entinen     O
kansleri    O
Eero        B-PER
Vuorio      I-PER
on          O
palkittu    O
```

The corpus annotation marks mentions of person (`PER`), organization (`ORG`), location (`LOC`), product (`PRO`) and event (`EVENT`) names as well as dates (`DATE`).

Most NER taggers can be straightforwardly trained and evaluated with this data. In our experiments with the corpus, the best performance was achieved with the [keras-bert-ner](https://github.com/jouniluoma/keras-bert-ner) tagger using the [FinBERT](https://turkunlp.org/finbert) model.

## Guidelines

The [Turku NER corpus annotation guidelines](https://github.com/TurkuNLP/turku-ner-corpus/blob/master/docs/Turku-NER-guidelines-v1.pdf) are available in PDF format.

## Reference

https://www.aclweb.org/anthology/2020.lrec-1.567.pdf:

```
@inproceedings{luoma-etal-2020-broad,
    title = "A Broad-coverage Corpus for {F}innish Named Entity Recognition",
    author = {Luoma, Jouni and Oinonen, Miika and Pyyk{\"o}nen, Maria and Laippala, Veronika and Pyysalo, Sampo},
    booktitle = "Proceedings of The 12th Language Resources and Evaluation Conference",
    year = "2020",
    url = "https://www.aclweb.org/anthology/2020.lrec-1.567",
    pages = "4615--4624",
}
```
