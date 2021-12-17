grammar MyPy;

/**
 * Parser Rules
 */

program: (COMMENT | assignment)*;

assignment: SYMBOL '=' STRING;

/**
 * Lexer Rules
 */

COMMENT: '#' ~[\r\n]*;

SYMBOL: [a-zA-Z_] [a-zA-Z0-9_]*;

STRING: '"' ~["]* '"';

WHITESPACE: ' ' -> skip;

NEWLINE: '\r'? '\n' -> skip;
