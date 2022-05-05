import ply.lex as lex
import ply.yacc as yacc

class LexerError(Exception):
    pass

class ParserError(Exception):
    pass

tokens = [
    "CURLY_START",
    "CURLY_END",
    "SQUARE_START",
    "SQUARE_END",
    "COMMA",
    "COLON",
    "NUMBER",
    "STRING",
    "TRUE",
    "FALSE",
    "NULL",
]

t_ignore = " \t\n"

def t_CURLY_START(t):
    r"\{"
    return t

def t_CURLY_END(t):
    r"\}"
    return t

def t_SQUARE_START(t):
    r"\["
    return t

def t_SQUARE_END(t):
    r"\]"
    return t

def t_COMMA(t):
    r","
    return t

def t_COLON(t):
    r":"
    return t

def t_TRUE(t):
    r"true"
    t.value = True
    return t

def t_FALSE(t):
    r"false"
    t.value = False
    return t

def t_NULL(t):
    r"null"
    t.value = None
    return t

def t_STRING(t):
    r'"(([^"\\])|(\\["\\\/bfnrt])|(\\u[0-9a-f]{4}))*"'
    t.value = t.value[1:-1]  # Remove quotation marks
    return t

def t_NUMBER(t):
    r'\-?(0|([1-9][0-9]*))(\.[0-9]*)?([eE][\+\-]?[0-9]*)?'
    try:
        t.value = int(t.value)
    except:
        t.value = float(t.value)
    return t

def t_error(t):
    raise LexerError(t)

def p_Value(p):
    """Value : STRING
             | NUMBER
             | CURLY_START Object CURLY_END
             | SQUARE_START List SQUARE_END
             | Bool
             | NULL
    """
    if len(p) == 4:
        p[0] = p[2]
    else:
        p[0] = p[1]

def p_Bool(p):
    """
    Bool : TRUE
               | FALSE
    """
    p[0] = p[1]

def p_List(p):
    """
    List : List COMMA Value
               | Value
               | empty
    """
    p[0] = []
    if len(p) == 2:
        # 1 empty | Value
        if p[1] is not None:
            p[0].append(p[1])
            pass
        pass
    if len(p) == 4:
        # 1 List 2 COMMA 3 Value
        for item in p[1]:
            p[0].append(item)
        p[0].append(p[3])
        pass

def p_Object(p):
    """
    Object : Object COMMA STRING COLON Value
                 | STRING COLON Value
                 | empty
    """
    p[0] = {}
    if len(p) == 4:
        # 1 STRING 2 COLON 3 Value
        p[0][p[1]] = p[3]
        pass
    if len(p) == 6:
        # 1 Object 2 COMMA 3 STRING 4 COMMA 5 Value
        for key, value in p[1].items():
            p[0][key] = value
        p[0][p[3]] = p[5]
        pass

def p_empty(p):
    """empty :  """

def p_error(p):
    print(p)
    raise ParserError(p)

# Build the lexer
lexer = lex.lex()
# Build the parser
parser = yacc.yacc()

data = """
{ 
    "hello" : 12345,
    "world" : "hello",
    "list" : [1, 2]
}
"""

def lex():
    lexer.input(data)
    while True:
        tok = lexer.token()
        if not tok:
            break  # No more input
        print(tok.type, tok.value)
        pass
    pass

def parse():
    result = parser.parse(data)
    print(result)

if __name__ == '__main__':
    lex()
    parse()
