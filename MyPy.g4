grammar MyPy;

/**
 * Parser Rules
 */

program: (COMMENT)*;

/**
 * Lexer Rules
 */

COMMENT: '#' ~[\r\n]*;

WHITESPACE: ' ' -> skip;

NEWLINE: '\r'? '\n' -> skip;
