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
    TypeModuleImports         ModuleImports
    TypeModuleExports         ModuleExports
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
%token <TypeToken> SEMI_COMMA

%token<TypeString>  DEFINITIONS_SYMBOL
%token<TypeString>  ASSIGNMENT_SYMBOL
%token<TypeString>  BEGIN_SYMBOL
%token<TypeString>  END_SYMBOL
%token<TypeString>  INSTRUCTIONS_SYMBOL
%token<TypeString>  EXPLICIT_SYMBOL
%token<TypeString>  IMPLICIT_SYMBOL
%token<TypeString>  AUTOMATIC_SYMBOL
%token<TypeString>  TAGS_SYMBOL
%token<TypeString>  EXTENSIBILITY_SYMBOL
%token<TypeString>  IMPLIED_SYMBOL
%token<TypeString>  EXPORTS_SYMBOL
%token<TypeString>  IMPORTS_SYMBOL
%token<TypeString>  ALL_SYMBOL

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
%type<TypeModuleImports>         ParseImports
%type<TypeModuleExports>         ParseExports
%type<TypeString>                ParseAssigmentList
%type<TypeString>                ParseSymbolsExported

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
    ParseExports
    ParseImports
    ParseAssigmentList {
        $$ = ModuleBody{
            Exports: $1,
            Imports: $2,
        }
    }

ParseImports:
    /*EMPTY*/ {
        $$ = ModuleImports {
            //Empty
        }
    }

ParseExports:
    EXPORTS_SYMBOL ParseSymbolsExported SEMI_COMMA {
        $$ = ModuleExports {
            //Empty
        }
    }
  | EXPORTS_SYMBOL ALL_SYMBOL SEMI_COMMA {
        $$ = ModuleExports {
            All: true,
        }
    }
  | /*EMPTY*/ {
        $$ = ModuleExports {
            //Empty
        }
    }

ParseAssigmentList:
    {
        $$ = ""
    }

ParseSymbolsExported:
    {
        $$ = ""
    }
%%