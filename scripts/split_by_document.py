#!/usr/bin/env python

import os
import sys
import re

from collections import defaultdict


SENT_ID_RE = re.compile('^#\s*sent_id\s*=\s*(\S+)\s*$')


def group_into_sentences(conll_lines):
    sentences = []
    current = []
    for line in conll_lines:
        current.append(line)
        if not line or line.isspace():    # sentence break
            sentences.append(current)
            current = []
    return sentences


def get_document_id(sentence):
    for line in sentence:
        m = SENT_ID_RE.match(line)
        if m:
            sentence_id = m.group(1)
            # UD-Fi-TDT convention:
            document_id, sentence_idx = sentence_id.split('.')
            return document_id
    raise ValueError('failed to find doc id: {}'.format(sentence))


def group_into_documents(sentences):
    sentences_by_docid = defaultdict(list)
    for s in sentences:
        docid = get_document_id(s)
        sentences_by_docid[docid].append(s)
    return sentences_by_docid


def main(argv):
    if len(argv) != 2:
        print('Usage: {} FILE'.format(os.path.basename(__file__)),
              file=sys.stderr)
        return 1

    with open(argv[1]) as f:
        lines = [l.rstrip('\n') for l in f]

    sentences = group_into_sentences(lines)
    sentences_by_docid = group_into_documents(sentences)

    for docid, sentences in sentences_by_docid.items():
        with open('{}.conllu'.format(docid), 'wt') as f:
            for s in sentences:
                for l in s:
                    print(l, file=f)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
