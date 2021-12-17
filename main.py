#!/usr/bin/env python3
"""
Nelson Earle
CS 4450 - Final Project
2021/12/16
"""

import sys

from antlr4 import CommonTokenStream, FileStream, InputStream, ParseTreeWalker
from antlr4.error.ErrorListener import ErrorListener
from antlr4.error.Errors import ParseCancellationException
from antlr4.tree import Tree

from gen.MyPyLexer import MyPyLexer
from gen.MyPyParser import MyPyParser


class MainThrowingErrorListener(ErrorListener):
    """
    Handle parse errors by throwing an exception rather than printing.
    """

    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        ex = ParseCancellationException(f'=== {line}:{column}: {msg}')
        # ex.line = line
        # ex.column = column
        raise ex

    # def reportAmbiguity(self, recognizer, dfa, startIndex, stopIndex, exact, ambigAlts, configs):
    #     pass


def handle(tree):
    for child in tree.getChildren():
        print(f'child: {child}')


def main(argv):
    in_stream = None
    if len(argv) == 2:
        in_stream = FileStream(argv[1])
    else:
        in_stream = InputStream(sys.stdin.readline())

    lexer = MyPyLexer(in_stream)
    lexer.removeErrorListeners()
    lexer.addErrorListener(MainThrowingErrorListener())

    tokens = CommonTokenStream(lexer)
    parser = MyPyParser(tokens)
    parser.removeErrorListeners()
    parser.addErrorListener(MainThrowingErrorListener())

    try:
        handle(parser.program())
    except ParseCancellationException as ex:
        print(ex)
        # return 1

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
