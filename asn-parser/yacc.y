%{
package main
func SetResult(l ASNLexer, v ModuleDefinitions) {
    l.(*Parser).Result = v
}
type Empty struct{}
%}

%union {
    TypeModuleDefinitions     ModuleDefinitions
    TypeModuleDefinition      ModuleDefinition
    TypeModuleIdentifer       ModuleIdentifier
    TypeDefinitiveIdentifiers DefinitiveIdentifiers
    TypeDefinitiveIdentifier  DefinitiveIdentifier
    TypeTagDefault            TagDefault
    TypeModuleBody            ModuleBody
    TypeToken                 Empty
    TypeString                string
    TypeInteger               int
    TypeFloat                 float64
    TypeBoolean               bool
}

%token <TypeToken> CURLY_START
%token <TypeToken> CURLY_END
%token <TypeToken> SQUARE_START
%token <TypeToken> SQUARE_END
%token <TypeToken> DOUBLE_QUOTE
%token <TypeToken> COMMA
%token <TypeToken> COLON
%token <TypeToken> MINUS
%token <TypeToken> GREATER_THAN
%token <TypeToken> LESS_THAN
%token <TypeToken> DOT
%token <TypeToken> SLASH
%token <TypeToken> ROUND_START
%token <TypeToken> ROUND_END
%token <TypeToken> EQUALITY
%token <TypeToken> APOSTROPHE
%token <TypeToken> SPACE
%token <TypeToken> PIPE
%token <TypeToken> AT_THE_RATE
%token <TypeToken> EXCLAMATION
%token <TypeToken> CARET

%token<TypeToken>  DEFINITIONS_SYMBOL
%token<TypeToken>  ASSIGNMENT_SYMBOL
%token<TypeToken>  BEGIN_SYMBOL
%token<TypeToken>  END_SYMBOL
%token<TypeToken>  INSTRUCTIONS_SYMBOL
%token<TypeToken>  EXPLICIT_SYMBOL
%token<TypeToken>  IMPLICIT_SYMBOL
%token<TypeToken>  AUTOMATIC_SYMBOL
%token<TypeToken>  TAGS_SYMBOL
%token<TypeToken>  EXTENSIBILITY_SYMBOL
%token<TypeToken>  IMPLIED_SYMBOL

%token<TypeString>  TokenString
%token<TypeInteger> TokenInteger
%token<TypeFloat>   TokenFloat
%token<TypeBoolean> TokenBoolean

%type<TypeModuleDefinitions>     ParseModules
%type<TypeModuleDefinition>      ParseModule
%type<TypeModuleIdentifer>       ParseModuleIdentifier
%type<TypeDefinitiveIdentifiers> ParseDefinitiveIdentification
%type<TypeDefinitiveIdentifiers> ParseDefinitiveOID
%type<TypeDefinitiveIdentifiers> ParseDefinitiveObjIdComponentList
%type<TypeDefinitiveIdentifier>  ParseDefinitiveObjIdComponent
%type<TypeDefinitiveIdentifier>  ParseDefinitiveNameForm
%type<TypeDefinitiveIdentifier>  ParseDefinitiveNumberForm
%type<TypeDefinitiveIdentifier>  ParseDefinitiveNameAndNumberForm
%type<TypeString>                ParseEncodingReferenceDefault
%type<TypeTagDefault>            ParseTagDefault
%type<TypeBoolean>               ParseExtensionDefault
%type<TypeModuleBody>            ParseModuleBody

%start ParseASN

%%
ParseASN:
    ParseModules
    {
        SetResult(ASNlex, $1)
    }

ParseModules:
    ParseModule {
        $$ = []ModuleDefinition {
            $1,
        }
    }
  | ParseModules ParseModule {
        $$ = $1
        $$ = append($$, $2)
    }

ParseModule:
    ParseModuleIdentifier          // 1
    DEFINITIONS_SYMBOL             // 2
    ParseEncodingReferenceDefault  // 3
    ParseTagDefault                // 4
    ParseExtensionDefault          // 5
    ASSIGNMENT_SYMBOL              // 6
    BEGIN_SYMBOL                   // 7
    ParseModuleBody                // 8
    END_SYMBOL                     // 9
    {
        $$ = ModuleDefinition {
            Identifier: $1,
            EncodingReference: $3,
            Tag: $4,
            Extensibility: $5,
            Body: $8,
        }
    }

ParseModuleIdentifier:
    TokenString
    ParseDefinitiveIdentification
    {
        $$ = ModuleIdentifier {
            Reference: $1,
            DefinitiveIdentifiers: $2,
        }
    }

ParseDefinitiveIdentification:
    ParseDefinitiveOID {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = make(DefinitiveIdentifiers, 0)
    }

ParseDefinitiveOID:
    CURLY_START ParseDefinitiveObjIdComponentList CURLY_END {
        $$ = $2
    }

ParseDefinitiveObjIdComponentList:
    ParseDefinitiveObjIdComponent {
        $$ = []DefinitiveIdentifier {
            $1,
        }
    }
  | ParseDefinitiveObjIdComponentList ParseDefinitiveObjIdComponent {
        $$ = $1
        $$ = append($$, $2)
    }

ParseDefinitiveObjIdComponent:
    ParseDefinitiveNameForm {
        $$ = $1
    }
  | ParseDefinitiveNumberForm {
        $$ = $1
    }
  | ParseDefinitiveNameAndNumberForm {
        $$ = $1
    }

ParseDefinitiveNameForm:
    TokenString {
        $$ = DefinitiveIdentifier {
            Name: $1,
        }
    }

ParseDefinitiveNumberForm:
    TokenInteger {
        $$ = DefinitiveIdentifier {
            Id: $1,
        }
    }

ParseDefinitiveNameAndNumberForm:
    TokenString ROUND_START TokenInteger ROUND_END {
        $$ = DefinitiveIdentifier {
            Name: $1,
            Id: $3,
        }
    }

ParseEncodingReferenceDefault:
    TokenString INSTRUCTIONS_SYMBOL {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = ""
    }

ParseTagDefault:
    IMPLICIT_SYMBOL TAGS_SYMBOL {
        $$ = ImplicitTag
    }
  | EXPLICIT_SYMBOL TAGS_SYMBOL {
        $$ = ExplicitTag
    }
  | AUTOMATIC_SYMBOL TAGS_SYMBOL {
        $$ = AutomaticTag
    }
  | /*EMPTY*/ {
        $$ = ExplicitTag
    }

ParseExtensionDefault:
    EXTENSIBILITY_SYMBOL IMPLIED_SYMBOL {
        $$ = true
    }
  | /*EMPTY*/ {
        $$ = false
    }

ParseModuleBody:
    {
        $$ = ModuleBody{
        }
    }
%%