grammar MyPy;

/**
 * Parser Rules
 */

program: (COMMENT | assignment)*;

assignment: SYMBOL '=' (STRING | NUMBER);

/**
 * Lexer Rules
 */

COMMENT: '#' ~[\r\n]*;

SYMBOL: [a-zA-Z_] [a-zA-Z0-9_]*;

STRING: '"' ~["]* '"';

NUMBER: '-'? [0-9]+;

WHITESPACE: ' ' -> skip;

NEWLINE: '\r'? '\n' -> skip;
