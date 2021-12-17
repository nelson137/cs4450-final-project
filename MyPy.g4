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

// Expressions

expr: exprNum | exprStr;
exprNum: (SYMBOL | NUMBER) CMP_OP (SYMBOL | NUMBER);
exprStr: STRING | SYMBOL '+' exprStr | exprStr '+' SYMBOL;

// Statements

stmt: stmtAssign | stmtIf | stmtFuncCall;

stmtAssign: SYMBOL '=' (STRING | NUMBER);

stmtIf:
	'if' test ':' INDENT ifBody NL DEDENT (
		'elif' test ':' INDENT ifBody NL DEDENT
	)* ('else:' INDENT ifBody NL DEDENT)?;
test: expr;
ifBody: stmt | NL INDENT stmt+ DEDENT;

stmtFuncCall: SYMBOL '(' (expr (',' expr)*)? ')';

/**
 * Lexer Rules
 */

fragment DIGITS: [0-9]+;

COMMENT: '#' ~[\r\n]*;

SYMBOL: [a-zA-Z_] [a-zA-Z0-9_]*;

STRING: '"' ~["]* '"';

NUMBER: '-'? DIGITS ('.' DIGITS)?;

CMP_OP: '>' | '<' | '>=' | '<=' | '==' | '!=';

WHITESPACE: ' ' -> skip;

NL: '\r'? '\n' ' '*;
