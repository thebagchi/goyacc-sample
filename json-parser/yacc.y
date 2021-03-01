
%{
package main

func SetResult(l yyLexer, v interface{}) {
  l.(*Parser).Result = v
}

%}

%union{
    TypeToken   struct{}
    TypeString  string
    TypeNumber  float64
    TypeValue   interface{}
    TypeBoolean bool
    TypeNull    struct{}
    TypeObject  map[string]interface{}
    TypeList    []interface{}
}

%token <TypeToken> CURLY_START
%token <TypeToken> CURLY_END
%token <TypeToken> SQUARE_START
%token <TypeToken> SQUARE_END
%token <TypeToken> DOUBLE_QUOTE
%token <TypeToken> COMMA
%token <TypeToken> COLON
%token <TypeToken> MINUS

%token <TypeNumber>  TokenNumber
%token <TypeString>  TokenString
%token <TypeBoolean> TokenBoolean
%token <TypeNull>    TokenNull
%token <TypeObject>  TokenObject
%token <TypeList>    TokenList
%token <TypeValue>   TokenValue

%type <TypeString>   ParseString
%type <TypeNumber>   ParseNumber
%type <TypeBoolean>  ParseBoolean
%type <TypeObject>   ParseDict
%type <TypeList>     ParseList
%type <TypeValue>    ParseValue
%type <TypeNull>     ParseNull

%start ParseJson

%%

ParseJson:
    ParseValue {
        SetResult(yylex, $1)
    }

ParseValue:
    ParseBoolean {
        $$ = $1
    }
  | ParseString {
        $$ = $1
    }
  | ParseNumber {
        $$ = $1
    }
  | CURLY_START CURLY_END {
        $$ = make(map[string]interface{})
    }
  | CURLY_START ParseDict CURLY_END {
        $$ = $2
    }
  | SQUARE_START SQUARE_END {
        $$ = make([]interface{}, 0)
    }
  | SQUARE_START ParseList SQUARE_END {
        $$ = $2
    }
  | ParseNull {
        $$ = nil
    }

ParseString:
    TokenString {
        $$ = $1
    }

ParseNumber:
    TokenNumber {
        $$ = $1
    }
  | MINUS TokenNumber {
      $$ = (-1) * $2
    }

ParseDict:
    TokenString COLON ParseValue {
        $$ = map[string]interface{} {
            $1 : $3,
        }
    }
  | ParseDict COMMA TokenString COLON ParseValue {
        $$ = $1
        $$[$3] = $5
    }

ParseList:
    ParseValue {
        $$ = []interface{} {
            $1,
        }
    }
  | ParseList COMMA ParseValue {
        $$ = $1
        $$ = append($$, $3)
    }

ParseBoolean:
    TokenBoolean {
        $$ = $1
    }

ParseNull:
    TokenNull {
        $$ = $1
    }

%%


