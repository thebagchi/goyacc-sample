%{
package main

func SetResult(l yyLexer, v interface{}) {
  l.(*Parser).Result = v
}

%}

%union{
}

%start ParseXML

%%
ParseXML:
    {
        SetResult(yylex, "")
    }
%%