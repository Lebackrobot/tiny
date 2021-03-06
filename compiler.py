# python3 compiler.py [input_file [output_file]]
#pip3 install antlr4-python3-runtime

import sys
from antlr4 import *
from modules.tinyLexer  import TinyLexer
from modules.tinyParser import TinyParser

if len(sys.argv) > 1:
    sys.stdin = open(sys.argv[1], 'r')
    
    if len(sys.argv) > 2:    
        sys.stdout = open(sys.argv[2], 'w')

input_stream = InputStream(sys.stdin.read())

lexer = TinyLexer(input_stream)
tokens = CommonTokenStream(lexer)
parser = TinyParser(tokens)

parser.program()