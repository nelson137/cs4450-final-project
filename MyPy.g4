grammar MyPy;

/**
 * Parser Rules
 */

program: (COMMENT | assignment)*;

assignment: SYMBOL '=' (STRING | NUMBER);

/**
 * Lexer Rules
 */

fragment DIGITS: [0-9]+;

COMMENT: '#' ~[\r\n]*;

SYMBOL: [a-zA-Z_] [a-zA-Z0-9_]*;

STRING: '"' ~["]* '"';

NUMBER: '-'? DIGITS ('.' DIGITS)?;

WHITESPACE: ' ' -> skip;

NEWLINE: '\r'? '\n' -> skip;
