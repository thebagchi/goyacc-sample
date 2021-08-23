%{
package main
import (
    "bytes"
    "fmt"
    "encoding/json"
)
var code bytes.Buffer
func AddLine(line string) {
    code.WriteString(line)
    code.WriteByte('\n')
}

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

func Join(values ...string) string {
    var buffer bytes.Buffer
    for _, value := range values {
        buffer.WriteString(value)
    }
    return buffer.String()
}

func SetResult(l ASNLexer, v VALUE) {
    l.(*Parser).Result = JSON(&v)
}

type Empty   struct{}
type (
    VALUE   interface{}
    STRING  string
    NUMBER  float64
    BOOLEAN bool
    LIST    []VALUE
    MAP     map[string]VALUE
)
%}

%union {
    TypeToken   struct{}
    TypeString  STRING
    TypeNumber  NUMBER
    TypeValue   VALUE
    TypeBoolean BOOLEAN
    TypeMap     MAP
    TypeList    LIST
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
%token<TypeNumber>  TokenNumber
%token<TypeBoolean> TokenBoolean

%type<TypeList>     ParseModules
%type<TypeMap>      ParseModule
%type<TypeMap>      ParseModuleIdentifier
%type<TypeList>     ParseDefinitiveIdentification
%type<TypeList>     ParseDefinitiveOID
%type<TypeList>     ParseDefinitiveObjIdComponentList
%type<TypeMap>      ParseDefinitiveObjIdComponent
%type<TypeMap>      ParseDefinitiveNameForm
%type<TypeMap>      ParseDefinitiveNumberForm
%type<TypeMap>      ParseDefinitiveNameAndNumberForm
%type<TypeString>   ParseTagDefault
%type<TypeString>   ParseEncodingReferenceDefault
%type<TypeBoolean>  ParseExtensionDefault
%type<TypeMap>      ParseModuleBody
%type<TypeList>     ParseImports
%type<TypeMap>      ParseExports
%type<TypeList>     ParseImportSymbols
%type<TypeList>     ParseSymbolsFromModules
%type<TypeMap>      ParseSymbolsFromModule
%type<TypeList>     ParseSymbols
%type<TypeString>   ParseSymbol
%type<TypeMap>      ParseGlobalModuleReference
%type<TypeList>     ParseAssignedIdentifier
%type<TypeList>     ParseObjectIdentifierValue
%type<TypeList>     ParseObjIdComponentsList
%type<TypeMap>      ParseObjIdComponents
%type<TypeMap>      ParseObjIdComponentsNameForm
%type<TypeMap>      ParseObjIdComponentsNumberForm
%type<TypeMap>      ParseObjIdComponentsNameAndNumberForm
%type<TypeList>     ParseAssignments
%type<TypeMap>      ParseAssignment
%type<TypeString>   ParseAssignementSymbol
%type<TypeString>   ParseString
%type<TypeNumber>   ParseNumber

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

ParseModules:
    ParseModule {
        $$ = LIST {
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
        $$ = MAP {
            "identifier": $1,
            "encoding":   $3,
            "tag":        $4,
            "body":       $8,
        }
    }

ParseModuleIdentifier:
    ParseString
    ParseDefinitiveIdentification
    {
        $$ = MAP {
            "reference":             $1,
            "definitiveIdentifiers": $2,
        }
    }

ParseEncodingReferenceDefault:
    TokenCapitalString INSTRUCTIONS_SYMBOL {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = ""
    }

ParseDefinitiveIdentification:
    ParseDefinitiveOID {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = nil
    }

ParseDefinitiveOID:
    CURLY_START ParseDefinitiveObjIdComponentList CURLY_END {
        $$ = $2
    }

ParseDefinitiveObjIdComponentList:
    ParseDefinitiveObjIdComponent {
        $$ = LIST {
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
        $$ = MAP {
            "name": $1,
        }
    }

ParseDefinitiveNumberForm:
    ParseNumber {
        $$ = MAP {
            "number": $1,
        }
    }

ParseDefinitiveNameAndNumberForm:
    TokenString ROUND_START ParseNumber ROUND_END {
        $$ = MAP {
            "name": $1,
            "number": $3,
        }
    }

ParseTagDefault:
    IMPLICIT_SYMBOL TAGS_SYMBOL {
        $$ = "Implicit"
    }
  | EXPLICIT_SYMBOL TAGS_SYMBOL {
        $$ = "Explicit"
    }
  | AUTOMATIC_SYMBOL TAGS_SYMBOL {
        $$ = "Automatic"
    }
  | /*EMPTY*/ {
        $$ = "Explicit"
    }

ParseExtensionDefault:
    EXTENSIBILITY_SYMBOL IMPLIED_SYMBOL {
        $$ = true
    }
  | /*EMPTY*/ {
        $$ = false
    }

ParseModuleBody:
    ParseImports
    ParseExports
    ParseAssignments {
      $$ = MAP {
          "imports":     $1,
          "exports":     $2,
          "assignments": $3,
      }
    }
  | ParseExports
    ParseImports
    ParseAssignments {
        $$ = MAP {
            "imports":     $2,
            "exports":     $1,
            "assignments": $3,
        }
    }
  | /* EMPTY */ {
      $$ = nil
    }

ParseExports:
    EXPORTS_SYMBOL ParseSymbols SEMI_COMMA {
      $$ = MAP {
          "all":     "false",
          "symbols": $2,
      }
    }
  |  EXPORTS_SYMBOL ALL_SYMBOL SEMI_COMMA {
      $$ = MAP {
          "all": "true",
      }
    }
  | EXPORTS_SYMBOL SEMI_COMMA {
      $$ = MAP {
          "all": "false",
      }
    }
  | /* EMPTY */ {
      $$ = MAP {
          "all": "true",
      }
  }

ParseSymbols:
    ParseSymbol {
         $$ = LIST {
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

ParseImports:
    IMPORTS_SYMBOL ParseImportSymbols SEMI_COMMA {
      $$ = $2
    }
  | /* EMPTY */ {
      $$ = nil
    }

ParseImportSymbols:
   ParseSymbolsFromModules {
       $$ = $1
   }
 | /* EMPTY */ {
       $$ = nil
   }

ParseSymbolsFromModules:
    ParseSymbolsFromModule {
        $$ = LIST {
            $1,
        }
    }
  | ParseSymbolsFromModules ParseSymbolsFromModule {
        $$ = $1
        $$ = append($$, $2)
    }

ParseSymbolsFromModule:
    ParseSymbols FROM_SYMBOL ParseGlobalModuleReference {
        $$ = MAP {
            "symbols":   $1,
            "reference": $3,
        }
    }

ParseGlobalModuleReference:
    ParseString ParseAssignedIdentifier {
       $$ = MAP {
           "name":        $1,
           "identifiers": $2,
       }
    }

ParseAssignedIdentifier:
    ParseObjectIdentifierValue {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = $1
    }
  | /* EMPTY */ {
        $$ = nil
    }

ParseObjectIdentifierValue:
    CURLY_START ParseObjIdComponentsList CURLY_END {
        $$ = $2
    }
  | CURLY_START ParseDefinedValue ParseObjIdComponentsList CURLY_START {
        $$ = $2
    }
  | CURLY_START CURLY_END {
      $$ = nil
    }

ParseObjIdComponentsList:
    ParseObjIdComponents {
        $$ = LIST {
            $1,
        }
    }
  | ParseObjIdComponentsList ParseObjIdComponents  {
        $$ = append($1, $2)
    }

ParseObjIdComponents:
    ParseObjIdComponentsNameForm {
        $$ = $1
    }
  | ParseObjIdComponentsNumberForm {
        $$ = $1
    }
  | ParseObjIdComponentsNameAndNumberForm {
        $$ = $1
    }

ParseObjIdComponentsNameForm:
   ParseString {
       $$ = MAP {
           "name": $1,
       }
   }

ParseObjIdComponentsNumberForm:
    ParseNumber {
        $$ = MAP {
            "number": $1,
        }
    }
  | ParseNumber {
        $$ = MAP {
            "number": $1,
        }
    }

ParseObjIdComponentsNameAndNumberForm:
    ParseString ROUND_START ParseNumber ROUND_END {
        $$ = MAP {
            "name":   $1,
            "number": $3,
        }
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
        $$ = nil
    }

ParseAssignment
    ParseTypeAssignment {
        $$ = $1
    }
  | ParseValueAssignment {
        $$ = $1
    }
  | ParseXMLValueAssignment {
        $$ = $1
    }
  | ParseValueSetTypeAssignment {
        $$ = $1
    }
  | ParseObjectClassAssignment {
        $$ = $1
    }
  | ParseObjectAssignment {
        $$ = $1
    }
  | ParseObjectSetAssignment {
        $$ = $1
    }
  | ParseParameterizedAssignment {
        $$ = $1
    }

ParseTypeAssignment:
    ParseString ParseAssignementSymbol ParseType {
        $$ = MAP {
            "assignment": "TYPE",
            "reference":  $1,
            "type":       $2,
        }
    }

ParseValueAssignment:
    ParseString ParseType ParseAssignementSymbol ParseValue {
        $$ = MAP {
            "assignment": "VALUE",
            "reference":  $1,
            "type":       $2,
            "value":      $4,
        }
    }

ParseXMLValueAssignment:
    ParseString ParseAssignementSymbol ParseXMLTypedValue {
        $$ = MAP {
            "assignment": "XML_VALUE",
            "reference":  $1,
            "value":      $3,
        }
    }

ParseValueSetTypeAssignment:
    ParseString ParseType ParseAssignementSymbol ParseValueSet {
        $$ = MAP {
            "assignment": "VALUE_SET",
            "reference":  $1,
            "type":       $2,
            "values":     $4,
        }
    }

ParseObjectClassAssignment:
    ParseString ParseAssignementSymbol ParseObjectClass {
        $$ = MAP {
            "assignment": "OBJECT_CLASS",
            "reference":  $1,
            "class":      $3,
        }
    }

ParseObjectAssignment:
    ParseString ParseDefinedObjectClass ParseAssignementSymbol ParseObject {
        $$ = MAP {
            "assignment": "OBJECT",
            "reference":  $1,
            "class":      $2,
            "value":      $4,
        }
    }

ParseObjectSetAssignment:
    ParseString ParseDefinedObjectClass ParseAssignementSymbol ParseObjectSet {
        $$ = MAP {
            "assignment": "OBJECT_SET",
            "reference":  $1,
            "class":      $2,
            "values":     $4,
        }
    }

ParseParameterizedAssignment:
    ParseParameterizedTypeAssignment {
        $$ = $1
    }
  | ParseParameterizedValueAssignment {
        $$ = $1
    }
  | ParseParameterizedValueSetTypeAssignment {
        $$ = $1
    }
  | ParseParameterizedObjectClassAssignment {
        $$ = $1
    }
  | ParseParameterizedObjectAssignment {
        $$ = $1
    }
  | ParseParameterizedObjectSetAssignment {
        $$ = $1
    }

ParseType:
    ParseBuiltinType {

    }
  | ParseReferencedType {

    }
  | ParseConstrainedType {

    }

ParseValue:

ParseXMLTypedValue:

ParseValueSet:

ParseObjectClass:

ParseDefinedObjectClass:

ParseObject:

ParseObjectSet:

ParseParameterizedTypeAssignment:

ParseParameterizedValueAssignment:

ParseParameterizedValueSetTypeAssignment:

ParseParameterizedObjectClassAssignment:

ParseParameterizedObjectAssignment:

ParseParameterizedObjectSetAssignment:

ParseDefinedValue:

ParseBuiltinType:

ParseReferencedType:

ParseConstrainedType:

ParseString:
    TokenCapitalString {
        $$ = $1
    }
  | TokenString {
        $$ = $1
    }

ParseNumber:
    TokenNumber {
        $$ = $1
    }
  | MINUS TokenNumber {
        $$ = (-1) * $2
    }

ParseAssignementSymbol:
    COLON COLON EQUALITY {
        $$ = "::="
    }
%%