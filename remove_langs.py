#! /usr/bin/env python

import re
import os
import os.path
import difflib

langs = [r'C\#', r'PHP', r'Java']
lang_pattern = r'\\textbf\{(?:%s)\}\s+\\begin\{verbatim\}.*?\\end\{verbatim\}' % "|".join(langs)
lang_pattern = re.compile(lang_pattern, re.MULTILINE | re.DOTALL)

def main():
    a = False
    for f in os.listdir("TEX/SUB/"):
        if f.endswith(".tex"):
            full_f = os.path.join("TEX/SUB/", f)
            content = open(full_f).read()
            content = re.sub(lang_pattern, "", content)
            with open(full_f, 'w') as ofile:
                ofile.write(content)

if __name__ == "__main__":
    main()
