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
%type<TypeValue>    ParseDefinedType
%type<TypeValue>    ParseUsefulType
%type<TypeValue>    ParseSelectionType
%type<TypeValue>    PaseTypeFromObject
%type<TypeValue>    ParseValueSetFromObjects
%type<TypeValue>    ParseExternalTypeReference
%type<TypeValue>    ParseParameterizedType
%type<TypeValue>    ParseParameterizedValueSetType
%type<TypeValue>    ParseSimpleDefinedType
%type<TypeValue>    ParseReferencedObjects
%type<TypeValue>    ParseFieldName
%type<TypeValue>    ParseActualParameter
%type<TypeValue>    ParseEncodingControlSection
%type<TypeValue>    ParseEncodingInstructionAssignmentList
%type<TypeValue>    ParseDefinedObject
%type<TypeValue>    ParseParameterizedObject
%type<TypeValue>    ParseDefinedObjectSet
%type<TypeValue>    ParseParameterizedObjectSet
%type<TypeValue>    ParseExternalObjectReference
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
    ParseEncodingControlSection {
        $$ = LIST {
            $1,
        }
    }
  | ParseEncodingControlSections ParseEncodingControlSections {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * EncodingControlSection ::=
 *      ENCODING-CONTROL
 *      encodingreference
 *      EncodingInstructionAssignmentList
 *****************************************************************************/
ParseEncodingControlSection:
    ENCODINGCONTROL_SYMBOL TokenCapitalString ParseEncodingInstructionAssignmentList {
        $$ = MAP {
            "encodingReference":    $2,
            "encodingInstructions": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * International Standard identified by the "encodingreference" (see Annex E) and can consist of any
 *  sequence of ASN.1 lexical items (including comment, cstring and white-space) except the lexical items END and
 *  ENCODING-CONTROL, which will not appear in an "EncodingInstructionAssignmentList"
 *****************************************************************************/
ParseEncodingInstructionAssignmentList:
    // TODO: ParseEncodingInstructionAssignmentList
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
        $$ = MAP {
            "name": $1,
        }
    }
  | ParseNumberForm {
        $$ = MAP {
            "number": $1,
        }
    }
  | ParseNameAndNumberForm {
        $$ = MAP {
            "nameAndNumber": $1,
        }
    }
  | ParseDefinedValue {
        $$ = MAP {
            "definedValue": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NameForm ::=
 *      identifier
 *****************************************************************************/
ParseNameForm:
   ParseString {
       $$ = $1
   }

/******************************************************************************
 * BNF Definition:
 * NumberForm ::=
 *      number
 *      | DefinedValue
 *****************************************************************************/
ParseNumberForm:
    ParseNumber {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = MAP {
            "definedValue": $1,
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
        $$ = MAP {
            "typeAssignment": $1,
        }
    }
  | ParseValueAssignment {
        $$ = MAP {
            "valueAssignment": $1,
        }
    }
  | ParseXMLValueAssignment {
        $$ = MAP {
            "xmlValueAssignment": $1,
        }
    }
  | ParseValueSetTypeAssignment {
        $$ = MAP {
            "valueSetAssignment": $1,
        }
    }
  | ParseObjectClassAssignment {
        $$ = MAP {
            "objectClassAssignment": $1,
        }
    }
  | ParseObjectAssignment {
        $$ = MAP {
            "objectAssignment": $1,
        }
    }
  | ParseObjectSetAssignment {
        $$ = MAP {
            "objectSetAssignment": $1,
        }
    }
  | ParseParameterizedAssignment {
        $$ = MAP {
            "parameterizedAssignment": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TypeAssignment ::=
 *      typereference
 *      "::="
 *      Type
 *****************************************************************************/
ParseTypeAssignment:
    ParseString ParseAssignementSymbol ParseType {
        $$ = MAP {
            "reference":  $1,
            "type":       $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ValueAssignment ::=
 *      valuereference
 *      Type
 *      "::="
 *      Value
 *****************************************************************************/
ParseValueAssignment:
    ParseString ParseType ParseAssignementSymbol ParseValue {
        $$ = MAP {
            "reference":  $1,
            "type":       $2,
            "value":      $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * XMLValueAssignment ::=
 *      valuereference
 *      "::="
 *      XMLTypedValue
 *****************************************************************************/
ParseXMLValueAssignment:
    ParseString ParseAssignementSymbol ParseXMLTypedValue {
        $$ = MAP {
            "reference":  $1,
            "value":      $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ValueSetTypeAssignment ::=
 *      typereference
 *      Type
 *      "::="
 *      ValueSet
 *****************************************************************************/
ParseValueSetTypeAssignment:
    ParseString ParseType ParseAssignementSymbol ParseValueSet {
        $$ = MAP {
            "reference":  $1,
            "type":       $2,
            "valueSet":   $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectClassAssignment ::=
 *      objectclassreference
 *      "::="
 *      ObjectClass
 *****************************************************************************/
ParseObjectClassAssignment:
    ParseString ParseAssignementSymbol ParseObjectClass {
        $$ = MAP {
            "reference":  $1,
            "class":      $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectAssignment ::=
 *      objectreference
 *      DefinedObjectClass
 *      "::="
 *      Object
 *****************************************************************************/
ParseObjectAssignment:
    ParseString ParseDefinedObjectClass ParseAssignementSymbol ParseObject {
        $$ = MAP {
            "reference":    $1,
            "definedClass": $2,
            "object":       $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectSetAssignment ::=
 *      objectsetreference
 *      DefinedObjectClass
 *      "::="
 *      ObjectSet
 *****************************************************************************/
ParseObjectSetAssignment:
    ParseString ParseDefinedObjectClass ParseAssignementSymbol ParseObjectSet {
        $$ = MAP {
            "reference":    $1,
            "definedClass": $2,
            "objectSet":    $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedAssignment ::=
 *      ParameterizedTypeAssignment
 *      | ParameterizedValueAssignment
 *      | ParameterizedValueSetTypeAssignment
 *      | ParameterizedObjectClassAssignment
 *      | ParameterizedObjectAssignment
 *      | ParameterizedObjectSetAssignment
 *****************************************************************************/
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

/******************************************************************************
 * BNF Definition:
 * Type ::=
 *      BuiltinType
 *      | ReferencedType
 *      | ConstrainedType
 *****************************************************************************/
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

/******************************************************************************
 * BNF Definition:
 * Value ::=
 *      BuiltinValue
 *      | ReferencedValue
 *      | ObjectClassFieldValue
 *****************************************************************************/
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

/******************************************************************************
 * BNF Definition:
 * BuiltinType ::=
 *      BitStringType
 *      | BooleanType
 *      | CharacterStringType
 *      | ChoiceType
 *      | DateType
 *      | DateTimeType
 *      | DurationType
 *      | EmbeddedPDVType
 *      | EnumeratedType
 *      | ExternalType
 *      | InstanceOfType
 *      | IntegerType
 *      | IRIType
 *      | NullType
 *      | ObjectClassFieldType
 *      | ObjectIdentifierType
 *      | OctetStringType
 *      | RealType
 *      | RelativeIRIType
 *      | RelativeOIDType
 *      | SequenceType
 *      | SequenceOfType
 *      | SetType
 *      | SetOfType
 *      | TimeType
 *      | TimeOfDayType
 *****************************************************************************/
ParseBuiltinType:
    ParseBitStringType {
        $$ = MAP {
            "bitStringType": $1,
        }
    }
  | ParseBooleanType {
        $$ = MAP {
            "booleanType": $1,
        }
    }
  | ParseCharacterStringType {
        $$ = MAP {
            "characterStringType": $1,
        }
    }
  | ParseChoiceType {
        $$ = MAP {
            "choiceType": $1,
        }
    }
  | ParseDateType {
        $$ = MAP {
            "dateType": $1,
        }
    }
  | ParseDateTimeType {
        $$ = MAP {
            "dataTimeType": $1,
        }
    }
  | ParseDurationType {
        $$ = MAP {
            "durationType": $1,
        }
    }
  | ParseEmbeddedPDVType {
        $$ = MAP {
            "embeddedPDVType": $1,
        }
    }
  | ParseEnumeratedType {
        $$ = MAP {
            "enumeratedType": $1,
        }
    }
  | ParseExternalType {
        $$ = MAP {
            "externalType": $1,
        }
    }
  | ParseInstanceOfType {
        $$ = MAP {
            "instanceOfType": $1,
        }
    }
  | ParseIntegerType {
        $$ = MAP {
            "integerType": $1,
        }
    }
  | ParseIRIType {
        $$ = MAP {
            "iriType": $1,
        }
    }
  | ParseNullType {
        $$ = MAP {
            "nullType": $1,
        }
    }
  | ParseObjectClassFieldType {
        $$ = MAP {
            "objectClassFieldType": $1,
        }
    }
  | ParseObjectIdentifierType {
        $$ = MAP {
            "objectIdentifierType": $1,
        }
    }
  | ParseOctetStringType {
        $$ = MAP {
            "octetStringType": $1,
        }
    }
  | ParseRealType {
        $$ = MAP {
            "realType": $1,
        }
    }
  | ParseRelativeIRIType {
        $$ = MAP {
            "relativeIRIType": $1,
        }
    }
  | ParseRelativeOIDType {
        $$ = MAP {
            "relativeOIDType": $1,
        }
    }
  | ParseSequenceType {
        $$ = MAP {
            "sequenceType": $1,
        }
    }
  | ParseSequenceOfType {
        $$ = MAP {
            "sequenceOfType": $1,
        }
    }
  | ParseSetType {
        $$ = MAP {
            "setType": $1,
        }
    }
  | ParseSetOfType {
        $$ = MAP {
            "setOfType": $1,
        }
    }
  | ParsePrefixedType {
        $$ = MAP {
            "prefixedType": $1,
        }
    }
  | ParseTimeType {
        $$ = MAP {
            "timeType": $1,
        }
    }
  | ParseTimeOfDayType {
        $$ = MAP {
            "timeOfDayType": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ReferencedType ::=
 *      DefinedType
 *      | UsefulType
 *      | SelectionType
 *      | TypeFromObject
 *      | ValueSetFromObjects
 *****************************************************************************/
ParseReferencedType:
    ParseDefinedType {
        $$ = MAP {
            "definedType": $1,
        }
    }
  | ParseUsefulType {
        $$ = MAP {
            "usefulType": $1,
        }
    }
  | ParseSelectionType {
        $$ = MAP {
            "selectionType": $1,
        }
    }
  | PaseTypeFromObject {
        $$ = MAP {
            "typeFromObject": $1,
        }
    }
  | ParseValueSetFromObjects {
        $$ = MAP {
            "valueSetFromObjects": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * DefinedType ::=
 *      ExternalTypeReference
 *      | typereference
 *      | ParameterizedType
 *      | ParameterizedValueSetType
 *****************************************************************************/
ParseDefinedType:
    ParseExternalTypeReference {
        $$ = MAP {
            "externalTypeReference": $1,
        }
    }
  | ParseString {
        $$ = MAP {
            "typeReference": $1,
        }
    }
  | ParseParameterizedType {
        $$ = MAP {
            "parameterizedType": $1,
        }
    }
  | ParseParameterizedValueSetType {
        $$ = MAP {
            "parameterizedValueSetType": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExternalTypeReference ::=
 *      modulereference
 *      "."
 *      typereference
 *****************************************************************************/
ParseExternalTypeReference:
    ParseString DOT ParseString {
        $$ = MAP {
            "moduleReference": $1,
            "typeReference":   $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedType ::=
 *      SimpleDefinedType
 *      ActualParameterList
 *****************************************************************************/
ParseParameterizedType:
    ParseSimpleDefinedType ParseActualParameterList {
        $$ = MAP {
            "simpleDefinedType":   $1,
            "actualParameterList": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedValueSetType ::=
 *      SimpleDefinedType
 *      ActualParameterList
 *****************************************************************************/
ParseParameterizedValueSetType:
    ParseSimpleDefinedType ParseActualParameterList {
        $$ = MAP {
            "simpleDefinedType":   $1,
            "actualParameterList": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SimpleDefinedType ::=
 *      ExternalTypeReference
 *      | typereference
 *****************************************************************************/
ParseSimpleDefinedType:
    ParseExternalTypeReference {
        $$ = MAP {
            "externalTypeReference": $1,
        }
    }
  | ParseString {
        $$ = MAP {
            "typeReference": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ActualParameterList ::= "{" ActualParameter "," + "}"
 *****************************************************************************/
ParseActualParameterList:
    CURLY_START ParseActualParameter CURLY_END {
        $$ = LIST {
            $1,
        }
    }
  | CURLY_START ParseActualParameterList COMMA ParseActualParameter CURLY_END {
        $$ = $1
        $$ = append($$.(LIST), $2)
    }

/******************************************************************************
 * BNF Definition:
 * ActualParameter ::=
 *      Type
 *      | Value
 *      | ValueSet
 *      | DefinedObjectClass
 *      | Object
 *      | ObjectSet
 *****************************************************************************/
ParseActualParameter:
    ParseType {
        $$ = MAP {
            "type": $1,
        }
    }
  | ParseValue {
        $$ = MAP {
            "value": $1,
        }
    }
  | ParseValueSet {
        $$ = MAP {
            "valueSet": $1,
        }
    }
  | ParseDefinedObjectClass {
        $$ = MAP {
            "definedObjectClass": $1,
        }
    }
  | ParseObject {
        $$ = MAP {
            "object": $1,
        }
    }
  | ParseObjectSet {
        $$ = MAP {
            "objectSet": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * UsefulType ::= typereference
 * Following are the useful types
 * UTF8String
 * GraphicString
 * NumericString
 * VisibleString
 * PrintableString
 * ISO646String
 * TeletexString
 * GeneralString
 * T61String
 * UniversalString
 * VideotexString
 * BMPString
 * IA5String
 * GeneralizedTime
 * UTCTime
 * ObjectDescriptor
 *****************************************************************************/
ParseUsefulType:
    UTF8STRING_SYMBOL {
        $$ = STRING(UTF8String)
    }
  | GRAPHICSTRING_SYMBOL {
        $$ = STRING(GraphicString)
    }
  | NUMERICSTRING_SYMBOL {
        $$ = STRING(NumericString)
    }
  | VISIBLESTRING_SYMBOL {
        $$ = STRING(VisibleString)
    }
  | PRINTABLESTRING_SYMBOL {
        $$ = STRING(PrintableString)
    }
  | ISO646STRING_SYMBOL {
        $$ = STRING(ISO646String)
    }
  | TELETEXSTRING_SYMBOL {
        $$ = STRING(TeletexString)
    }
  | GENERALSTRING_SYMBOL {
        $$ = STRING(GeneralString)
    }
  | T61STRING_SYMBOL {
        $$ = STRING(T61String)
    }
  | UNIVERSALSTRING_SYMBOL {
        $$ = STRING(UniversalString)
    }
  | VIDEOTEXSTRING_SYMBOL {
        $$ = STRING(VideotexString)
    }
  | BMPSTRING_SYMBOL {
        $$ = STRING(BMPString)
    }
  | IA5STRING_SYMBOL {
        $$ = STRING(IA5String)
    }
  | GENERALIZEDTIME_SYMBOL {
        $$ = STRING(GeneralizedTime)
    }
  | UTCTIME_SYMBOL {
        $$ = STRING(UTCTime)
    }
  | OBJECTDESCRIPTOR_SYMBOL {
        $$ = STRING(ObjectDescriptor)
    }

/******************************************************************************
 * BNF Definition:
 * SelectionType ::=
 *      identifier "<" Type
 *****************************************************************************/
ParseSelectionType:
    ParseString LESS_THAN ParseType {
        $$ = MAP {
            "identifier": $1,
            "type":       $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TypeFromObject ::=
 *      ReferencedObjects "." FieldName
 *****************************************************************************/
PaseTypeFromObject:
    ParseReferencedObjects DOT ParseFieldName {
        $$ = MAP {
            "referencedObjects": $1,
            "fieldName":         $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ReferencedObjects ::=
 *      DefinedObject | ParameterizedObject | DefinedObjectSet | ParameterizedObjectSet
 *****************************************************************************/
ParseReferencedObjects:
    ParseDefinedObject {
        $$ = MAP {
            "definedObject": $1,
        }
    }
  | ParseParameterizedObject {
        $$ = MAP {
            "parameterizedObject": $1,
        }
    }
  | ParseDefinedObjectSet {
        $$ = MAP {
            "definedObjectSet": $1,
        }
    }
  | ParseParameterizedObjectSet {
        $$ = MAP {
            "parameterizedObjectSet": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * DefinedObject ::=
 *      ExternalObjectReference | objectreference
 *****************************************************************************/
ParseDefinedObject:
    ParseExternalObjectReference{
        $$ = MAP {
            "externalObjectReference": $1,
        }
    }
  | ParseString {
        $$ = MAP {
            "objectReference": $1,
        }
    }

ParseExternalObjectReference:
    // TODO: ParseExternalObjectReference
    /* EMPTY */ {
        $$ = nil
    }
ParseParameterizedObject:
    // TODO: ParseParameterizedObject
    /* EMPTY */ {
        $$ = nil
    }

ParseDefinedObjectSet:
    // TODO: ParseDefinedObjectSet
    /* EMPTY */ {
        $$ = nil
    }

ParseParameterizedObjectSet:
    // TODO: ParseParameterizedObjectSet
    /* EMPTY */ {
        $$ = nil
    }

ParseFieldName:
    // TODO: ParseFieldName
    /* EMPTY */ {
        $$ = nil
    }

ParseValueSetFromObjects:
    // TODO: ParseValueSetFromObjects
    /* EMPTY */ {
        $$ = nil
    }

ParseConstrainedType:
    // TODO: ParseConstrainedType
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