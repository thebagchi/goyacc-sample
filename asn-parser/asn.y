%{
package main
import (
    "fmt"
    "encoding/json"
)
func JSON(obj interface{}) string {
    data, err := json.MarshalIndent(obj, "", "    ")
    if nil != err {
        fmt.Println("Error: ", err)
        return ""
    }
    return string(data)
}
func Print(line string) {
    fmt.Println(line)
}
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
    TypeModuleImport          ModuleImport
    TypeModuleReference       ModuleReference
    TypeAssignment            Assignment
    TypeAssignments           Assignments
    TypeToken                 Empty
    TypeString                string
    TypeInteger               int
    TypeFloat                 float64
    TypeBoolean               bool
    TypeListString            []string
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

%token<TypeString>  ABSENT_SYMBOL
%token<TypeString>  ABSTRACTSYNTAX_SYMBOL
%token<TypeString>  ALL_SYMBOL
%token<TypeString>  APPLICATION_SYMBOL
%token<TypeString>  AUTOMATIC_SYMBOL
%token<TypeString>  BEGIN_SYMBOL
%token<TypeString>  BIT_SYMBOL
%token<TypeString>  BMPSTRING_SYMBOL
%token<TypeString>  BOOLEAN_SYMBOL
%token<TypeString>  BY_SYMBOL
%token<TypeString>  CHARACTER_SYMBOL
%token<TypeString>  CHOICE_SYMBOL
%token<TypeString>  CLASS_SYMBOL
%token<TypeString>  COMPONENT_SYMBOL
%token<TypeString>  COMPONENTS_SYMBOL
%token<TypeString>  CONSTRAINED_SYMBOL
%token<TypeString>  CONTAINING_SYMBOL
%token<TypeString>  DATE_SYMBOL
%token<TypeString>  DATETIME_SYMBOL
%token<TypeString>  DEFAULT_SYMBOL
%token<TypeString>  DEFINITIONS_SYMBOL
%token<TypeString>  DURATION_SYMBOL
%token<TypeString>  EMBEDDED_SYMBOL
%token<TypeString>  ENCODED_SYMBOL
%token<TypeString>  ENCODINGCONTROL_SYMBOL
%token<TypeString>  END_SYMBOL
%token<TypeString>  ENUMERATED_SYMBOL
%token<TypeString>  EXCEPT_SYMBOL
%token<TypeString>  EXPLICIT_SYMBOL
%token<TypeString>  EXPORTS_SYMBOL
%token<TypeString>  EXTENSIBILITY_SYMBOL
%token<TypeString>  EXTERNEL_SYMBOL
%token<TypeString>  FALSE_SYMBOL
%token<TypeString>  FROM_SYMBOL
%token<TypeString>  GENERALIZEDTIME_SYMBOL
%token<TypeString>  GENERALSTRING_SYMBOL
%token<TypeString>  GRAPHICSTRING_SYMBOL
%token<TypeString>  IA5STRING_SYMBOL
%token<TypeString>  IDENTIFIER_SYMBOL
%token<TypeString>  IMPLICIT_SYMBOL
%token<TypeString>  IMPLIED_SYMBOL
%token<TypeString>  IMPORTS_SYMBOL
%token<TypeString>  INCLUDES_SYMBOL
%token<TypeString>  INSTANCE_SYMBOL
%token<TypeString>  INSTRUCTIONS_SYMBOL
%token<TypeString>  INTEGER_SYMBOL
%token<TypeString>  INTERSECTION_SYMBOL
%token<TypeString>  ISO646STRING_SYMBOL
%token<TypeString>  MAX_SYMBOL
%token<TypeString>  MIN_SYMBOL
%token<TypeString>  MINUSINFINITY_SYMBOL
%token<TypeString>  NOTANUMBER_SYMBOL
%token<TypeString>  NULL_SYMBOL
%token<TypeString>  NUMERICSTRING_SYMBOL
%token<TypeString>  OBJECT_SYMBOL
%token<TypeString>  OBJECTDESCRIPTOR_SYMBOL
%token<TypeString>  OCTET_SYMBOL
%token<TypeString>  OF_SYMBOL
%token<TypeString>  OIDIRI_SYMBOL
%token<TypeString>  OPTIONAL_SYMBOL
%token<TypeString>  PATTERN_SYMBOL
%token<TypeString>  PDV_SYMBOL
%token<TypeString>  PLUSINFINITY_SYMBOL
%token<TypeString>  PRESENT_SYMBOL
%token<TypeString>  PRINTABLESTRING_SYMBOL
%token<TypeString>  PRIVATE_SYMBOL
%token<TypeString>  REAL_SYMBOL
%token<TypeString>  RELATIVEOID_SYMBOL
%token<TypeString>  RELATIVEOIDIRI_SYMBOL
%token<TypeString>  SEQUENCE_SYMBOL
%token<TypeString>  SET_SYMBOL
%token<TypeString>  SETTINGS_SYMBOL
%token<TypeString>  SIZE_SYMBOL
%token<TypeString>  STRING_SYMBOL
%token<TypeString>  SYNTAX_SYMBOL
%token<TypeString>  T61STRING_SYMBOL
%token<TypeString>  TAGS_SYMBOL
%token<TypeString>  TELETEXSTRING_SYMBOL
%token<TypeString>  TIME_SYMBOL
%token<TypeString>  TIMEOFDAY_SYMBOL
%token<TypeString>  TRUE_SYMBOL
%token<TypeString>  TYPEIDENTIFIER_SYMBOL
%token<TypeString>  UNION_SYMBOL
%token<TypeString>  UNIQUE_SYMBOL
%token<TypeString>  UNIVERSAL_SYMBOL
%token<TypeString>  UNIVERSALSTRING_SYMBOL
%token<TypeString>  UTCTIME_SYMBOL
%token<TypeString>  UTF8STRING_SYMBOL
%token<TypeString>  VIDEOTEXSTRING_SYMBOL
%token<TypeString>  VISIBLESTRING_SYMBOL
%token<TypeString>  WITH_SYMBOL

%token<TypeString>  ASSIGNMENT_SYMBOL

%token<TypeString>  TokenCapitalString
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
%type<TypeAssignments>           ParseAssignments
%type<TypeAssignment>            ParseAssignment
%type<TypeModuleImports>         ParseImports
%type<TypeModuleExports>         ParseExports
%type<TypeString>                ParseAssignementSymbol
%type<TypeTagDefault>            ParseTagDefault
%type<TypeBoolean>               ParseExtensionDefault
%type<TypeString>                ParseEncodingReferenceDefault
%type<TypeModuleBody>            ParseModuleBody
%type<TypeString>                ParseString
%type<TypeListString>            ParseSymbols
%type<TypeString>                ParseSymbol
%type<TypeModuleImports>         ParseImportSymbols
%type<TypeModuleImports>         ParseSymbolsFromModules
%type<TypeModuleImport>          ParseSymbolsFromModule
%type<TypeModuleReference>       ParseModuleReference

%start ParseASN

%%
ParseASN:
    ParseModules
    {
        SetResult(ASNlex, $1)
        Print("Done")
        Print("--------------------------------------------------------------------------------")
        Print(JSON(&$1))
        Print("--------------------------------------------------------------------------------")
    }

ParseString:
    TokenCapitalString {
        $$ = $1
    }
  | TokenString {
        $$ = $1
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
    ParseAssignementSymbol         // 6
    BEGIN_SYMBOL                   // 7
    ParseModuleBody                // 8
    END_SYMBOL                     // 9
    {
        $$ = ModuleDefinition {
            Identifier: $1,
            Body:       $8,
        }
    }

ParseAssignementSymbol:
    COLON COLON EQUALITY {
        $$ = "::="
    }

ParseModuleIdentifier:
    ParseString
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

ParseEncodingReferenceDefault:
    TokenCapitalString INSTRUCTIONS_SYMBOL {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = ""
    }

ParseModuleBody:
    ParseImports
    ParseExports
    ParseAssignments {
      $$ = ModuleBody {
          Imports: $1,
          Exports: $2,
      }
    }
  | ParseExports
    ParseImports
    ParseAssignments {
        $$ = ModuleBody {
            Imports: $2,
            Exports: $1,
        }
    }
  | /* EMPTY */ {
      $$ = ModuleBody {
          // Empty
      }
    }

ParseImports:
    IMPORTS_SYMBOL ParseImportSymbols SEMI_COMMA {
      $$ = $2
    }
  | /* EMPTY */ {
      $$ = []ModuleImport{
          // EMPTY
      }
    }

ParseImportSymbols:
   ParseSymbolsFromModules {
       $$ = $1
   }
 | /* EMPTY */ {
       $$ = []ModuleImport{
           // EMPTY
       }
   }

ParseSymbolsFromModules:
    ParseSymbolsFromModule {
        $$ = []ModuleImport{
            $1,
        }
    }
  | ParseSymbolsFromModules ParseSymbolsFromModule {
        $$ = $1
        $$ = append($$, $2)
    }

ParseSymbolsFromModule:
    ParseSymbols FROM_SYMBOL ParseModuleReference {
        $$ = ModuleImport{
            Symbols:   $1,
            Reference: $3,
        }
    }

ParseModuleReference:
    ParseString {
       $$ = ModuleReference{
           Identifier: $1,
       }
    }

ParseExports:
    EXPORTS_SYMBOL ParseSymbols SEMI_COMMA {
      $$ = ModuleExports {
          All:     false,
          Symbols: $2,
      }
    }
  |  EXPORTS_SYMBOL ALL_SYMBOL SEMI_COMMA {
      $$ = ModuleExports {
          All: true,
      }
    }
  | EXPORTS_SYMBOL SEMI_COMMA {
      $$ = ModuleExports {
          // Empty
      }
    }
  | /* EMPTY */ {
      $$ = ModuleExports {
          // Empty
      }
  }

ParseSymbols:
    ParseSymbol {
         $$ = []string{
             $1,
         }
    }
  | ParseSymbols COMMA ParseSymbol {
        $$ = $1
        $$ = append($$, $3)
    }

ParseSymbol:
    TokenString {
        $$ = $1
    }

ParseAssignments:
    ParseAssignment {
        $$ = []Assignment{
            $1,
        }
    }
  | ParseAssignments ParseAssignment {
      $$ = $1
      $$ = append($$, $2)
    }
  | /* EMPTY */ {
      $$ = []Assignment{
          // Empty
      }
    }

ParseAssignment:
    TokenString ParseAssignementSymbol {
        $$ = Assignment{
            // Empty
        }
    }
%%