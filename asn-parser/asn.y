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
%token <TypeToken> SINGLE_QUOTE
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
%token<TypeNumber>  TokenInteger
%token<TypeNumber>  TokenFloat
%token<TypeBoolean> TokenBoolean
%token<TypeString>  TokenBString
%token<TypeString>  TokenHString
%token<TypeString>  TokenCString

%type<TypeValue>    ParseModules
%type<TypeValue>    ParseModule
%type<TypeValue>    ParseModuleIdentifier
%type<TypeValue>    ParseDefinitiveIdentification
%type<TypeValue>    ParseDefinitiveOID
%type<TypeValue>    ParseDefinitiveObjIdComponentList
%type<TypeValue>    ParseDefinitiveObjIdComponent
%type<TypeValue>    ParseDefinitiveNameForm
%type<TypeValue>    ParseDefinitiveNumberForm
%type<TypeValue>    ParseDefinitiveNameAndNumberForm
%type<TypeValue>    ParseTagDefault
%type<TypeValue>    ParseEncodingReferenceDefault
%type<TypeValue>    ParseExtensionDefault
%type<TypeValue>    ParseModuleBody
%type<TypeValue>    ParseImports
%type<TypeValue>    ParseExports
%type<TypeValue>    ParseSymbolsImported
%type<TypeValue>    ParseSymbolsFromModuleList
%type<TypeValue>    ParseSymbolsFromModule
%type<TypeValue>    ParseSymbolsExported
%type<TypeValue>    ParseSymbolList
%type<TypeValue>    ParseSymbol
%type<TypeValue>    ParseGlobalModuleReference
%type<TypeValue>    ParseAssignedIdentifier
%type<TypeValue>    ParseObjectIdentifierValue
%type<TypeValue>    ParseObjIdComponentsList
%type<TypeValue>    ParseObjIdComponents
%type<TypeValue>    ParseNameForm
%type<TypeValue>    ParseNumberForm
%type<TypeValue>    ParseNameAndNumberForm
%type<TypeValue>    ParseAssignmentList
%type<TypeValue>    ParseAssignment
%type<TypeValue>    ParseDefinedValue
%type<TypeValue>    ParseTypeAssignment
%type<TypeValue>    ParseValueAssignment
%type<TypeValue>    ParseXMLValueAssignment
%type<TypeValue>    ParseValueSetTypeAssignment
%type<TypeValue>    ParseObjectClassAssignment
%type<TypeValue>    ParseObjectAssignment
%type<TypeValue>    ParseObjectSetAssignment
%type<TypeValue>    ParseParameterizedAssignment
%type<TypeValue>    ParseType
%type<TypeValue>    ParseValue
%type<TypeValue>    ParseValueSet
%type<TypeValue>    ParseXMLTypedValue
%type<TypeValue>    ParseObjectClass
%type<TypeValue>    ParseDefinedObjectClass
%type<TypeValue>    ParseObject
%type<TypeValue>    ParseObjectSet
%type<TypeValue>    ParseParameterizedTypeAssignment
%type<TypeValue>    ParseParameterizedValueAssignment
%type<TypeValue>    ParseParameterizedValueSetTypeAssignment
%type<TypeValue>    ParseParameterizedObjectClassAssignment
%type<TypeValue>    ParseParameterizedObjectAssignment
%type<TypeValue>    ParseParameterizedObjectSetAssignment
%type<TypeValue>    ParseBuiltinType
%type<TypeValue>    ParseReferencedType
%type<TypeValue>    ParseConstrainedType
%type<TypeValue>    ParseBitStringType
%type<TypeValue>    ParseBooleanType
%type<TypeValue>    ParseCharacterStringType
%type<TypeValue>    ParseChoiceType
%type<TypeValue>    ParseDateType
%type<TypeValue>    ParseDateTimeType
%type<TypeValue>    ParseDurationType
%type<TypeValue>    ParseEmbeddedPDVType
%type<TypeValue>    ParseExternalType
%type<TypeValue>    ParseEnumeratedType
%type<TypeValue>    ParseInstanceOfType
%type<TypeValue>    ParseIntegerType
%type<TypeValue>    ParseIRIType
%type<TypeValue>    ParseNullType
%type<TypeValue>    ParseObjectClassFieldType
%type<TypeValue>    ParseObjectIdentifierType
%type<TypeValue>    ParseOctetStringType
%type<TypeValue>    ParseRealType
%type<TypeValue>    ParseRelativeIRIType
%type<TypeValue>    ParseRelativeOIDType
%type<TypeValue>    ParseSequenceType
%type<TypeValue>    ParseSequenceOfType
%type<TypeValue>    ParseSetType
%type<TypeValue>    ParseSetOfType
%type<TypeValue>    ParsePrefixedType
%type<TypeValue>    ParseTimeType
%type<TypeValue>    ParseTimeOfDayType
%type<TypeValue>    ParseExternalValueReference
%type<TypeValue>    ParseParameterizedValue
%type<TypeValue>    ParseSimpleDefinedValue
%type<TypeValue>    ParseActualParameterList
%type<TypeValue>    ParseBuiltinValue
%type<TypeValue>    ParseReferencedValue
%type<TypeValue>    ParseObjectClassFieldValue
%type<TypeValue>    ParseBitStringValue
%type<TypeValue>    ParseBooleanValue
%type<TypeValue>    ParseCharacterStringValue
%type<TypeValue>    ParseChoiceValue
%type<TypeValue>    ParseEmbeddedPDVValue
%type<TypeValue>    ParseEnumeratedValue
%type<TypeValue>    ParseExternalValue
%type<TypeValue>    ParseInstanceOfValue
%type<TypeValue>    ParseIntegerValue
%type<TypeValue>    ParseIRIValue
%type<TypeValue>    ParseNullValue
%type<TypeValue>    ParseOctetStringValue
%type<TypeValue>    ParseRealValue
%type<TypeValue>    ParseRelativeIRIValue
%type<TypeValue>    ParseRelativeOIDValue
%type<TypeValue>    ParseSequenceValue
%type<TypeValue>    ParseSequenceOfValue
%type<TypeValue>    ParseSetValue
%type<TypeValue>    ParseSetOfValue
%type<TypeValue>    ParsePrefixedValue
%type<TypeValue>    ParseTimeValue
%type<TypeValue>    ParseRestrictedCharacterStringValue
%type<TypeValue>    ParseUnrestrictedCharacterStringValue
%type<TypeValue>    ParseIdentifierList
%type<TypeValue>    ParseIdentifier
%type<TypeValue>    ParseCharacterStringList
%type<TypeValue>    ParseQuadruple
%type<TypeValue>    ParseTuple
%type<TypeValue>    ParseCharSyms
%type<TypeValue>    ParseCharsDefn
%type<TypeValue>    ParseGroup
%type<TypeValue>    ParsePlane
%type<TypeValue>    ParseRow
%type<TypeValue>    ParseCell
%type<TypeValue>    ParseTableColumn
%type<TypeValue>    ParseTableRow
%type<TypeValue>    ParseNumericRealValue
%type<TypeValue>    ParseSpecialRealValue
%type<TypeValue>    ParseRelativeOIDComponentsList
%type<TypeValue>    ParseRelativeOIDComponents
%type<TypeValue>    ParseEncodingControlSections
%type<TypeValue>    ParseReference
%type<TypeValue>    ParseParameterizedReference
%type<TypeValue>    ParseAssignementSymbol
%type<TypeValue>    ParseString
%type<TypeValue>    ParseNumber
%type<TypeValue>    ParseBoolean

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
        $$ = append($$.(LIST), $2)
    }

/******************************************************************************
 * BNF Definition:
 * ModuleDefinition ::=
 *     ModuleIdentifier
 *     DEFINITIONS
 *     EncodingReferenceDefault
 *     TagDefault
 *     ExtensionDefault
 *     "::="
 *     BEGIN
 *     ModuleBody
 *     EncodingControlSections
 *     END
 *****************************************************************************/
ParseModule:
    ParseModuleIdentifier          // 1
    DEFINITIONS_SYMBOL             // 2
    ParseEncodingReferenceDefault  // 3
    ParseTagDefault                // 4
    ParseExtensionDefault          // 5
    ParseAssignementSymbol         // 6
    BEGIN_SYMBOL                   // 7
    ParseModuleBody                // 8
    ParseEncodingControlSections   // 9
    END_SYMBOL                     // 10
    {
        $$ = MAP {
            "identifier": $1,
            "encoding":   $3,
            "tag":        $4,
            "body":       $8,
        }
    }

/******************************************************************************
 * BNF Definition:
 * EncodingControlSections ::=
 *  EncodingControlSection EncodingControlSections
 *  |empty
 *****************************************************************************/
ParseEncodingControlSections:
    /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ModuleIdentifier ::=
 *     modulereference
 *     DefinitiveIdentification
 *****************************************************************************/
ParseModuleIdentifier:
    ParseString
    ParseDefinitiveIdentification
    {
        $$ = MAP {
            "reference":             $1,
            "definitiveIdentifiers": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * EncodingReferenceDefault ::=
 *  encodingreference INSTRUCTIONS
 *  | empty
 *****************************************************************************/
ParseEncodingReferenceDefault:
    TokenCapitalString INSTRUCTIONS_SYMBOL {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = ""
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveIdentification ::=
 *   | DefinitiveOID
 *   | DefinitiveOIDandIRI
 *   | empty
 *****************************************************************************/
ParseDefinitiveIdentification:
    ParseDefinitiveOID {
        $$ = $1
    }
  | /*EMPTY*/ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveOID ::=
 *  "{" DefinitiveObjIdComponentList "}"
 *****************************************************************************/
ParseDefinitiveOID:
    CURLY_START ParseDefinitiveObjIdComponentList CURLY_END {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveObjIdComponentList ::=
 *  DefinitiveObjIdComponent
 *  | DefinitiveObjIdComponent DefinitiveObjIdComponentList
 *****************************************************************************/
ParseDefinitiveObjIdComponentList:
    ParseDefinitiveObjIdComponent {
        $$ = LIST {
            $1,
        }
    }
  | ParseDefinitiveObjIdComponentList ParseDefinitiveObjIdComponent {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveObjIdComponent ::=
 *  DefinitiveNameForm
 *  | DefinitiveNumberForm
 *  | DefinitiveNameAndNumberForm
 *****************************************************************************/
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

/******************************************************************************
 * BNF Definition:
 * NameForm ::= identifier
 *****************************************************************************/
ParseDefinitiveNameForm:
    TokenString {
        $$ = MAP {
            "name": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveNumberForm ::= number
 *****************************************************************************/
ParseDefinitiveNumberForm:
    ParseNumber {
        $$ = MAP {
            "number": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * DefinitiveNameAndNumberForm ::= identifier "(" DefinitiveNumberForm ")"
 *****************************************************************************/
ParseDefinitiveNameAndNumberForm:
    TokenString ROUND_START ParseNumber ROUND_END {
        $$ = MAP {
            "name": $1,
            "number": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TagDefault ::=
 *  EXPLICIT TAGS
 *  | IMPLICIT TAGS
 *  | AUTOMATIC TAGS
 *  | empty
 *****************************************************************************/
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

/******************************************************************************
 * BNF Definition:
 * ExtensionDefault ::=
 *  EXTENSIBILITY IMPLIED
 *  | empty
 *****************************************************************************/
ParseExtensionDefault:
    EXTENSIBILITY_SYMBOL IMPLIED_SYMBOL {
        $$ = true
    }
  | /*EMPTY*/ {
        $$ = false
    }

/******************************************************************************
 * BNF Definition:
 * ModuleBody ::=
 *  Exports Imports AssignmentList
 *  | empty
 *****************************************************************************/
ParseModuleBody:
    ParseImports
    ParseExports
    ParseAssignmentList {
      $$ = MAP {
          "imports":     $1,
          "exports":     $2,
          "assignments": $3,
      }
    }
  | ParseExports
    ParseImports
    ParseAssignmentList {
        $$ = MAP {
            "imports":     $2,
            "exports":     $1,
            "assignments": $3,
        }
    }
  | /* EMPTY */ {
      $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * Exports ::=
 *  EXPORTS SymbolsExported ";"
 *  | EXPORTS ALL ";"
 *  | empty
 *****************************************************************************/
ParseExports:
    EXPORTS_SYMBOL ParseSymbolsExported SEMI_COMMA {
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

/******************************************************************************
 * BNF Definition:
 * SymbolsExported ::=
 *  SymbolList
 *  | empty
 *****************************************************************************/
ParseSymbolsExported:
    ParseSymbolList {
         $$ = $1
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * SymbolList ::=
 *  Symbol
 *  | SymbolList "," Symbol
 *****************************************************************************/
ParseSymbolList:
    ParseSymbol {
         $$ = LIST {
             $1,
         }
    }
  | ParseSymbolList COMMA ParseSymbol {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * Symbol ::=
 *  Reference
 *  | ParameterizedReference
 *****************************************************************************/
ParseSymbol:
    ParseReference {
        $$ = MAP {
            "reference": $1,
        }
    }
  | ParseParameterizedReference {
        $$ = MAP {
            "parameterizedReference": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Reference ::=
 *  typereference
 *  | valuereference
 *  | objectclassreference
 *  | objectreference
 *  | objectsetreference
 *****************************************************************************/
ParseReference:
    // All the lexical items:
    //   typereference, valuereference, objectclassreference, objectreference, objectsetreference
    //   are string tokens.
    ParseString {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedReference ::=
 *     Reference | Reference "{" "}"
 *****************************************************************************/
ParseParameterizedReference:
    ParseReference {
        $$ = $1
    }
  | ParseReference CURLY_START CURLY_END {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * Imports ::=
 *      IMPORTS SymbolsImported ";"
 *      | empty
 *****************************************************************************/
ParseImports:
    IMPORTS_SYMBOL ParseSymbolsImported SEMI_COMMA {
      $$ = $2
    }
  | /* EMPTY */ {
      $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * SymbolsImported ::=
 *      SymbolsFromModuleList
 *      | empty
 *****************************************************************************/
ParseSymbolsImported:
   ParseSymbolsFromModuleList {
       $$ = $1
   }
 | /* EMPTY */ {
       $$ = nil
   }

/******************************************************************************
 * BNF Definition:
 * SymbolsFromModuleList ::=
 *      SymbolsFromModule
 *      | SymbolsFromModuleList SymbolsFromModule
 *****************************************************************************/
ParseSymbolsFromModuleList:
    ParseSymbolsFromModule {
        $$ = LIST {
            $1,
        }
    }
  | ParseSymbolsFromModuleList ParseSymbolsFromModule {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

/******************************************************************************
 * BNF Definition:
 * SymbolsFromModule ::=
 *      SymbolList FROM GlobalModuleReference
 *****************************************************************************/
ParseSymbolsFromModule:
    ParseSymbolList FROM_SYMBOL ParseGlobalModuleReference {
        $$ = MAP {
            "symbols":   $1,
            "reference": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * GlobalModuleReference ::=
 *      modulereference AssignedIdentifier
 *****************************************************************************/
ParseGlobalModuleReference:
    ParseString ParseAssignedIdentifier {
       $$ = MAP {
           "name":        $1,
           "identifiers": $2,
       }
    }

/******************************************************************************
 * BNF Definition:
 * AssignedIdentifier ::=
 *      ObjectIdentifierValue
 *      | DefinedValue
 *      | empty
 *****************************************************************************/
ParseAssignedIdentifier:
    ParseObjectIdentifierValue {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = nil
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ObjectIdentifierValue ::=
 *      "{" ObjIdComponentsList "}"
 *      | "{" DefinedValue ObjIdComponentsList "}"
 *****************************************************************************/
ParseObjectIdentifierValue:
    CURLY_START ParseObjIdComponentsList CURLY_END {
        $$ = $2
    }
  | CURLY_START ParseDefinedValue ParseObjIdComponentsList CURLY_START {
        $$ = $3
    }
  | CURLY_START CURLY_END {
      $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ObjIdComponentsList ::=
 *      ObjIdComponents
 *      | ObjIdComponents ObjIdComponentsList
 *****************************************************************************/
ParseObjIdComponentsList:
    ParseObjIdComponents {
        $$ = LIST {
            $1,
        }
    }
  | ParseObjIdComponentsList ParseObjIdComponents  {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

/******************************************************************************
 * BNF Definition:
 * ObjIdComponents ::=
 *      NameForm
 *      | NumberForm
 *      | NameAndNumberForm
 *      | DefinedValue
 *****************************************************************************/
ParseObjIdComponents:
    ParseNameForm {
        $$ = $1
    }
  | ParseNumberForm {
        $$ = $1
    }
  | ParseNameAndNumberForm {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * NameForm ::=
 *      identifier
 *****************************************************************************/
ParseNameForm:
   ParseString {
       $$ = MAP {
           "name": $1,
       }
   }

/******************************************************************************
 * BNF Definition:
 * NumberForm ::=
 *      number
 *      | DefinedValue
 *****************************************************************************/
ParseNumberForm:
    ParseNumber {
        $$ = MAP {
            "number": $1,
        }
    }
  | ParseDefinedValue {
        $$ = MAP {
            "number": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NameAndNumberForm ::=
 *      identifier "(" NumberForm ")"
 *****************************************************************************/
ParseNameAndNumberForm:
    ParseString ROUND_START ParseNumberForm ROUND_END {
        $$ = MAP {
            "name":   $1,
            "number": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * AssignmentList ::=
 *      Assignment
 *      | AssignmentList Assignment
 *****************************************************************************/
ParseAssignmentList:
    ParseAssignment {
        $$ = LIST {
            $1,
        }
    }
  | ParseAssignmentList ParseAssignment {
        $$ = $1
        $$ = append($$.(LIST), $2)
     }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * Assignment ::=
 *      TypeAssignment
 *      | ValueAssignment
 *      | XMLValueAssignment
 *      | ValueSetTypeAssignment
 *      | ObjectClassAssignment
 *      | ObjectAssignment
 *      | ObjectSetAssignment
 *      | ParameterizedAssignment
 *****************************************************************************/
ParseAssignment:
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
        $$ = MAP {
            "type":       "BUILTIN_TYPE",
            "properties": $1,
        }
    }
  | ParseReferencedType {
        $$ = MAP {
            "type":       "REFERENCED_TYPE",
            "properties": $1,
        }
    }
  | ParseConstrainedType {
        $$ = MAP {
            "type":       "CONSTRAINED_TYPE",
            "properties": $1,
        }
    }

ParseValue:
    ParseBuiltinValue {
        $$ = MAP {
            "type":       "BUILTIN_VALUE",
            "properties": $1,
        }
    }
  | ParseReferencedValue {
        $$ = MAP {
            "type":       "REFERENCED_VALUE",
            "properties": $1,
        }
    }
  | ParseObjectClassFieldValue {
        $$ = MAP {
            "type":       "OBJECT_CLASS_FIELD_VALUE",
            "properties": $1,
        }
    }

ParseBuiltinValue:
    ParseBitStringValue {
        $$ = MAP {
            "bitString": $1,
        }
    }
  | ParseBooleanValue {
        $$ = MAP {
            "boolean": $1,
        }
    }
  | ParseCharacterStringValue {
        $$ = MAP {
            "characterString": $1,
        }
    }
  | ParseChoiceValue {
        $$ = MAP {
            "choice": $1,
        }
    }
  | ParseEmbeddedPDVValue {
        $$ = MAP {
            "embeddedPDV": $1,
        }
    }
  | ParseEnumeratedValue {
        $$ = MAP {
            "enumerated": $1,
        }
    }
  | ParseExternalValue {
        $$ = MAP {
            "external": $1,
        }
    }
  | ParseInstanceOfValue {
        $$ = MAP {
            "instanceOf": $1,
        }
    }
  | ParseIntegerValue {
        $$ = MAP {
            "integer": $1,
        }
    }
  | ParseIRIValue {
        $$ = MAP {
            "iri": $1,
        }
    }
  | ParseNullValue {
        $$ = MAP {
            "null": $1,
        }
    }
  | ParseObjectIdentifierValue {
        $$ = MAP {
            "objectIdentifier": $1,
        }
    }
  | ParseOctetStringValue {
        $$ = MAP {
            "octetString": $1,
        }
    }
  | ParseRealValue {
        $$ = MAP {
            "real": $1,
        }
    }
  | ParseRelativeIRIValue {
        $$ = MAP {
            "relativeIRI": $1,
        }
    }
  | ParseRelativeOIDValue {
        $$ = MAP {
            "relativeOID": $1,
        }
    }
  | ParseSequenceValue {
        $$ = MAP {
            "sequence": $1,
        }
    }
  | ParseSequenceOfValue {
        $$ = MAP {
            "sequenceOf": $1,
        }
    }
  | ParseSetValue {
        $$ = MAP {
            "set": $1,
        }
    }
  | ParseSetOfValue {
        $$ = MAP {
            "setOf": $1,
        }
    }
  | ParsePrefixedValue {
        $$ = MAP {
            "prefixed": $1,
        }
    }
  | ParseTimeValue {
        $$ = MAP {
            "time": $1,
        }
    }

ParseBitStringValue:
    TokenBString {
        $$ = $1
    }
  | TokenHString {
        $$ = $1
    }
  | CURLY_START ParseIdentifierList CURLY_END {
        $$ = $2
    }
  | CURLY_START CURLY_END {
        $$ = nil
    }
  | CONTAINING_SYMBOL ParseValue {
        $$ = $2
    }

ParseIdentifierList:
    ParseIdentifier {
        $$ = LIST {
            $1,
        }
    }
  | ParseIdentifierList COMMA ParseIdentifier {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

ParseIdentifier:
    ParseString {
        $$ = $1
    }

ParseBooleanValue:
    ParseBoolean {
        $$ = $1
    }

ParseCharacterStringValue:
    ParseRestrictedCharacterStringValue {
        $$ = nil
    }
  | ParseUnrestrictedCharacterStringValue {

    }

ParseRestrictedCharacterStringValue:
    TokenCString {
        $$ = $1
    }
  | ParseCharacterStringList {
        $$ = $1
    }
  | ParseQuadruple {
        $$ = $1
    }
  | ParseTuple {
        $$ = $1
    }

ParseCharacterStringList:
    CURLY_START ParseCharSyms CURLY_END {
        $$ = nil
    }

ParseCharSyms:
    ParseCharsDefn {
        $$ = LIST{
            $1,
        }
    }
  | ParseCharSyms COMMA ParseCharsDefn {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

ParseCharsDefn:
    TokenCString {
        $$ = $1
    }
  | ParseQuadruple {
        $$ = $1
    }
  | ParseTuple {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = $1
    }

ParseQuadruple:
    CURLY_START ParseGroup COMMA ParsePlane COMMA ParseRow COMMA ParseCell CURLY_END {
        $$ = MAP {
            "group": $2,
            "plane": $4,
            "row":   $6,
            "cell":  $8,
        }
    }

ParseGroup:
    ParseNumber {
        $$ = $1
    }

ParsePlane:
    ParseNumber {
        $$ = $1
    }

ParseRow:
    ParseNumber {
        $$ = $1
    }

ParseCell:
    ParseNumber {
        $$ = $1
    }

ParseTuple:
    CURLY_START ParseTableColumn COMMA ParseTableRow CURLY_END {
        $$ = MAP {
            "tableColumn": $2,
            "tableRow":    $4,
        }
    }

ParseTableColumn:
    ParseNumber {
        $$ = $1
    }

ParseTableRow:
    ParseNumber {
        $$ = $1
    }

ParseUnrestrictedCharacterStringValue:
    ParseSequenceValue {
        $$ = $1
    }

ParseChoiceValue:
    ParseString COLON ParseValue {
        $$ = MAP {
            "identifier": $1,
            "value":      $2,
        }
    }

ParseEmbeddedPDVValue:
    ParseSequenceValue {
        $$ = nil
    }

ParseEnumeratedValue:
    ParseString {
        $$ = $1
    }

ParseExternalValue:
    ParseSequenceValue {
        $$ = $1
    }

ParseInstanceOfValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseIntegerValue:
    ParseNumber {
        $$ = $1
    }
  | ParseString {
        $$ = $1
    }

ParseNullValue:
    NULL_SYMBOL {
        $$ = "NULL"
    }

// Conflicts with ParseBitStringValue
ParseOctetStringValue:
    TokenBString {
        $$ = $1
    }
  | TokenHString {
        $$ = $1
    }
  CONTAINING_SYMBOL ParseValue {
        $$ = $1
    }

ParseRealValue:
    ParseNumericRealValue {
        $$ = $1
    }
  | ParseSpecialRealValue {
        $$ = nil
    }

ParseNumericRealValue:
    ParseNumber {
        $$ = $1
    }
  | ParseSequenceValue {
        $$ = $1
    }

ParseSpecialRealValue:
    PLUSINFINITY_SYMBOL {
        $$ = nil
    }
  | MINUSINFINITY_SYMBOL {
        $$ = nil
    }
  | NOTANUMBER_SYMBOL {
        $$ = nil
    }

ParseIRIValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseRelativeIRIValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseRelativeOIDValue:
    CURLY_START ParseRelativeOIDComponentsList CURLY_END {
        $$ = nil
    }

ParseRelativeOIDComponentsList:
    ParseRelativeOIDComponents {
        $$ = nil
    }
  | ParseRelativeOIDComponentsList ParseRelativeOIDComponents {
        $$ = nil
    }

ParseRelativeOIDComponents:
    ParseNumberForm {
        $$ = nil
    }
  | ParseNameAndNumberForm {
        $$ = nil
    }
  | ParseDefinedValue {
        $$ = nil
    }

ParseSequenceValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseSequenceOfValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseSetValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseSetOfValue:
    /* EMPTY */ {
        $$ = nil
    }

ParsePrefixedValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseTimeValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseReferencedValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseObjectClassFieldValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseXMLTypedValue:
    /* EMPTY */ {
        $$ = nil
    }

ParseValueSet:
    /* EMPTY */ {
        $$ = nil
    }

ParseObjectClass:
    /* EMPTY */ {
        $$ = nil
    }

ParseDefinedObjectClass:
    /* EMPTY */ {
        $$ = nil
    }

ParseObject:
    /* EMPTY */ {
        $$ = nil
    }

ParseObjectSet:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedTypeAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedValueAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedValueSetTypeAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedObjectClassAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedObjectAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedObjectSetAssignment:
    /* EMPTY */ {
        $$ = nil
    }

ParseDefinedValue:
    ParseExternalValueReference {
        $$ = MAP {
            "type":  "EXTERNAL_VALUE",
            "value": $1,
        }
    }
  | ParseString {
        $$ = MAP {
            "type":  "STRING_VALUE",
            "value": $1,
        }
    }
  | ParseNumber {
        $$ = MAP {
            "type":  "NUMBER_VALUE",
            "value": $1,
        }
    }
  | ParseParameterizedValue {
        $$ = MAP {
            "type":  "PARAMETERIZED_VALUE",
            "value": $1,
        }
    }

ParseExternalValueReference:
    ParseString DOT ParseString {
        $$ = MAP {
            "module": $1,
            "value":  $3,
        }
    }

ParseParameterizedValue:
    ParseSimpleDefinedValue ParseActualParameterList {
        $$ = nil
    }

ParseSimpleDefinedValue:
    {
        $$ = nil
    }

ParseActualParameterList:
    {
        $$ = nil
    }

ParseBuiltinType:
    ParseBitStringType {

    }
  | ParseBooleanType {

    }
  | ParseCharacterStringType {

    }
  | ParseChoiceType {

    }
  | ParseDateType {

    }
  | ParseDateTimeType {

    }
  | ParseDurationType {

    }
  | ParseEmbeddedPDVType {

    }
  | ParseEnumeratedType {

    }
  | ParseExternalType {

    }
  | ParseInstanceOfType {

    }
  | ParseIntegerType {

    }
  | ParseIRIType {

    }
  | ParseNullType {

    }
  | ParseObjectClassFieldType {

    }
  | ParseObjectIdentifierType {

    }
  | ParseOctetStringType {

    }
  | ParseRealType {

    }
  | ParseRelativeIRIType {

    }
  | ParseRelativeOIDType {

    }
  | ParseSequenceType {

    }
  | ParseSequenceOfType {

    }
  | ParseSetType {

    }
  | ParseSetOfType {

    }
  | ParsePrefixedType {

    }
  | ParseTimeType {

    }
  | ParseTimeOfDayType {

    }

ParseReferencedType:
    /* EMPTY */ {
        $$ = nil
    }

ParseConstrainedType:
    /* EMPTY */ {
        $$ = nil
    }

ParseBitStringType:
    /* EMPTY */ {
        $$ = nil
    }

ParseBooleanType:
    /* EMPTY */ {
        $$ = nil
    }

ParseCharacterStringType:
    /* EMPTY */ {
        $$ = nil
    }
ParseChoiceType:
    /* EMPTY */ {
        $$ = nil
    }

ParseDateType:
    /* EMPTY */ {
        $$ = nil
    }
ParseDateTimeType:
    /* EMPTY */ {
        $$ = nil
    }
ParseDurationType:
    /* EMPTY */ {
        $$ = nil
    }

ParseEmbeddedPDVType:
    /* EMPTY */ {
        $$ = nil
    }

ParseEnumeratedType:
    /* EMPTY */ {
        $$ = nil
    }

ParseExternalType:
    /* EMPTY */ {
        $$ = nil
    }

ParseInstanceOfType:
    /* EMPTY */ {
        $$ = nil
    }

ParseIntegerType:
    /* EMPTY */ {
        $$ = nil
    }

ParseIRIType:
    /* EMPTY */ {
        $$ = nil
    }

ParseNullType:
    /* EMPTY */ {
        $$ = nil
    }

ParseObjectClassFieldType:
    /* EMPTY */ {
        $$ = nil
    }

ParseObjectIdentifierType:
    /* EMPTY */ {
        $$ = nil
    }

ParseOctetStringType:
    /* EMPTY */ {
        $$ = nil
    }

ParseRealType:
    /* EMPTY */ {
        $$ = nil
    }

ParseRelativeIRIType:
    /* EMPTY */ {
        $$ = nil
    }

ParseRelativeOIDType:
    /* EMPTY */ {
        $$ = nil
    }

ParseSequenceType:
    /* EMPTY */ {
        $$ = nil
    }

ParseSequenceOfType:
    /* EMPTY */ {
        $$ = nil
    }

ParseSetType:
    /* EMPTY */ {
        $$ = nil
    }

ParseSetOfType:
    /* EMPTY */ {
        $$ = nil
    }

ParsePrefixedType:
    /* EMPTY */ {
        $$ = nil
    }

ParseTimeType:
    /* EMPTY */ {
        $$ = nil
    }

ParseTimeOfDayType:
    /* EMPTY */ {
        $$ = nil
    }

ParseBoolean:
    TRUE_SYMBOL {
        $$ = $1
    }
  | FALSE_SYMBOL {
        $$ = $1
    }

ParseString:
    TokenCapitalString {
        $$ = $1
    }
  | TokenString {
        $$ = $1
    }

ParseNumber:
    TokenInteger {
        $$ = $1
    }
  | MINUS TokenInteger {
        $$ = (-1) * $2
    }
  | TokenFloat {
        $$ = $1
    }
  | MINUS TokenFloat {
        $$ = (-1) * $2
    }

ParseAssignementSymbol:
    COLON COLON EQUALITY {
        $$ = "::="
    }
%%