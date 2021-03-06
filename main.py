#!/usr/bin/env python3
"""
Nelson Earle
CS 4450 - Final Project
2021/12/16
"""

import sys

from antlr4 import CommonTokenStream, FileStream, InputStream, TerminalNode
from antlr4.error.ErrorListener import ErrorListener
from antlr4.error.Errors import ParseCancellationException

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


def handle(tree, indent_level=0):
    indent = ' ' * indent_level
    for child in tree.getChildren():
        if isinstance(child, TerminalNode):
            value = str(child).encode("unicode_escape").decode('utf-8')
            print(f'{indent}node: {value}')
        else:
            type_name = type(child).__name__.replace('Context', '')
            print(f'{indent}node: {type_name}')
            handle(child, indent_level=indent_level+1)


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
    # parser.removeErrorListeners()
    # parser.addErrorListener(MainThrowingErrorListener())

    try:
        handle(parser.program())
    except ParseCancellationException as ex:
        print(ex)
        # return 1

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
