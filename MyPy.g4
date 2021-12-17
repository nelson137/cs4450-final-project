grammar MyPy;

/**
 * Parser Rules
 */

tokens {
	INDENT,
	DEDENT
}

@lexer::header {
from antlr_denter.DenterHelper import DenterHelper
from gen.MyPyParser import MyPyParser
}

@lexer::members {
class MyPyDenter(DenterHelper):
    def __init__(self, lexer, nl_token, indent_token, dedent_token, ignore_eof):
        super().__init__(nl_token, indent_token, dedent_token, ignore_eof)
        self.lexer: MyPyLexer = lexer

    def pull_token(self):
        return super(MyPyLexer, self.lexer).nextToken()

denter = None

def nextToken(self):
    if not self.denter:
        self.denter = self.MyPyDenter(self, self.NL, MyPyParser.INDENT, MyPyParser.DEDENT, False)
    return self.denter.next_token()
}

// Program

program: (comment | stmt | NL)* EOF;

// Comment

comment: COMMENT NL;

// Common

funcCall: SYMBOL '(' funcCallArgList? ')';
funcCallArgList: funcCallArg (',' funcCallArg)*;
funcCallArg: SYMBOL | expr;

// Expressions

expr: exprArith | expr OP_CMP expr;
exprArith: arithTerm (('+' | '-') arithTerm)*;
arithTerm: atom (('*' | '/' | '%' | '**') atom)*;
atom: SYMBOL | NUMBER | STRING | funcCall;

// Statements

stmt: stmtBreak | stmtIf | stmtFor | stmtAssign | stmtFuncCall;

stmtAssign: SYMBOL '=' expr NL;

stmtIf:
	'if' test ':' body ('elif' test ':' body)* ('else:' body)?;
test: '(' test ')' | expr;

stmtFuncCall: funcCall NL;

stmtFor: 'for' SYMBOL 'in' expr ':' body;

stmtBreak: 'break' NL;

body: INDENT stmt+ DEDENT;

/**
 * Lexer Rules
 */

fragment DIGITS: [0-9]+;

COMMENT: '#' ~[\r\n]*;

SYMBOL: [a-zA-Z_] [a-zA-Z0-9_]*;

STRING: '"' ~["]* '"';

NUMBER: '-'? DIGITS ('.' DIGITS)?;

OP_CMP: '>' | '<' | '>=' | '<=' | '==' | '!=';
OP_MATH: '**' | '*' | '/' | '%' | '+' | '-';

WHITESPACE: ' ' -> skip;

NL: '\r'? '\n' ' '*;
