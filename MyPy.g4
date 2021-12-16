grammar MyPy;

/**
 * Parser Rules
 */

addition: NUMBER '+' NUMBER;

/**
 * Lexer Rules
 */

NUMBER: [0-9]+;

WHITESPACE: ' ' -> skip;

NEWLINE: '\n' -> skip;
