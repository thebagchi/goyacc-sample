import ply.lex as lex
import ply.yacc as yacc

class LexerError(Exception):
    pass

class ParserError(Exception):
    pass

tokens = [
    "curly_start",
    "curly_end",
    "square_start",
    "square_end",
    "comma",
    "colon",
    "token_number",
    "token_string",
    "token_true",
    "token_false",
    "token_null",
]

t_ignore = " \t\n"

def t_curly_start(t):
    r"\{"
    return t

def t_curly_end(t):
    r"\}"
    return t

def t_square_start(t):
    r"\["
    return t

def t_square_end(t):
    r"\]"
    return t

def t_comma(t):
    r","
    return t

def t_colon(t):
    r":"
    return t

def t_token_true(t):
    r"true"
    t.value = True
    return t

def t_token_false(t):
    r"false"
    t.value = False
    return t

def t_token_null(t):
    r"null"
    t.value = None
    return t

def t_token_string(t):
    r'"(([^"\\])|(\\["\\\/bfnrt])|(\\u[0-9a-f]{4}))*"'
    t.value = t.value[1:-1]  # Remove quotation marks
    return t

def t_token_number(t):
    r'\-?(0|([1-9][0-9]*))(\.[0-9]*)?([eE][\+\-]?[0-9]*)?'
    try:
        t.value = int(t.value)
    except:
        t.value = float(t.value)
    return t

def t_error(t):
    raise LexerError(t)

def p_token_value(p):
    """token_value : token_string
                   | token_number
                   | curly_start token_object curly_end
                   | square_start token_list square_end
                   | token_bool
                   | token_null
    """
    if len(p) == 4:
        p[0] = p[2]
    else:
        p[0] = p[1]

def p_empty(p):
    """empty :  """

def p_token_bool(p):
    """
    token_bool : token_true
               | token_false
    """
    p[0] = p[1]

def p_token_list(p):
    """
    token_list : token_list comma token_value
               | token_value
               | empty
    """
    p[0] = []
    print("stb", len(p))
    if len(p) == 2:
        # 1 empty | token_value
        if p[1] is not None:
            p[0].append(p[1])
            pass
        pass
    if len(p) == 4:
        # 1 token_list 2 comma 3 token_value
        for item in p[1]:
            p[0].append(item)
        p[0].append(p[3])
        pass

def p_token_object(p):
    """
    token_object : token_object comma token_string colon token_value
                 | token_string colon token_value
                 | empty
    """
    p[0] = {}
    if len(p) == 4:
        # 1 token_string 2 colon 3 token_value
        p[0][p[1]] = p[3]
        pass
    if len(p) == 6:
        # 1 token_object 2 comma 3 token_string 4 comma 5 token_value
        for key, value in p[1].items():
            p[0][key] = value
        p[0][p[3]] = p[5]
        pass

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
