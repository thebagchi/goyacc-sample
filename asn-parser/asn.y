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

func SkipBlock() {
    parser.ExpectBlock = true
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
%token <TypeToken> ELLIPSIS

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
%token<TypeString>  TokenBlock

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
%type<TypeValue>    ParseExternalObjectSetReference
%type<TypeValue>    ParsePrimitiveFieldNameList
%type<TypeValue>    ParsePrimitiveFieldName
%type<TypeValue>    ParseConstraint
%type<TypeValue>    ParseTypeWithConstraint
%type<TypeValue>    ParseConstraintSpec
%type<TypeValue>    ParseExceptionSpec
%type<TypeValue>    ParseSubtypeConstraint
%type<TypeValue>    ParseGeneralConstraint
%type<TypeValue>    ParseElementSetSpecs
%type<TypeValue>    ParseRootElementSetSpec
%type<TypeValue>    ParseAdditionalElementSetSpec
%type<TypeValue>    ParseElementSetSpec
%type<TypeValue>    ParseUnions
%type<TypeValue>    ParseExclusions
%type<TypeValue>    ParseIntersections
%type<TypeValue>    ParseUElems
%type<TypeValue>    ParseUnionMark
%type<TypeValue>    ParseIntersectionElements
%type<TypeValue>    ParseIElems
%type<TypeValue>    ParseIntersectionMark
%type<TypeValue>    ParseElements
%type<TypeValue>    ParseElems
%type<TypeValue>    ParseSubtypeElements
%type<TypeValue>    ParseObjectSetElements
%type<TypeValue>    ParseSingleValue
%type<TypeValue>    ParseContainedSubtype
%type<TypeValue>    ParseValueRange
%type<TypeValue>    ParsePermittedAlphabet
%type<TypeValue>    ParseSizeConstraint
%type<TypeValue>    ParseTypeConstraint
%type<TypeValue>    ParseInnerTypeConstraints
%type<TypeValue>    ParsePatternConstraint
%type<TypeValue>    ParsePropertySettings
%type<TypeValue>    ParseDurationRange
%type<TypeValue>    ParseTimePointRange
%type<TypeValue>    ParseRecurrenceRange
%type<TypeValue>    ParseIncludes
%type<TypeValue>    ParseLowerEndpoint
%type<TypeValue>    ParseLowerEndValue
%type<TypeValue>    ParseUpperEndpoint
%type<TypeValue>    ParseUpperEndValue
%type<TypeValue>    ParseSingleTypeConstraint
%type<TypeValue>    ParseMultipleTypeConstraints
%type<TypeValue>    ParseFullSpecification
%type<TypeValue>    ParsePartialSpecification
%type<TypeValue>    ParseTypeConstraints
%type<TypeValue>    ParseNamedConstraint
%type<TypeValue>    ParseComponentConstraint
%type<TypeValue>    ParseValueConstraint
%type<TypeValue>    ParsePresenceConstraint
%type<TypeValue>    ParseObjectSetFromObjects
%type<TypeValue>    ParseUserDefinedConstraint
%type<TypeValue>    ParseTableConstraint
%type<TypeValue>    ParseContentsConstraint
%type<TypeValue>    ParseUserDefinedConstraintParameterList
%type<TypeValue>    ParseUserDefinedConstraintParameter
%type<TypeValue>    ParseGovernor
%type<TypeValue>    ParseSimpleTableConstraint
%type<TypeValue>    ParseComponentRelationConstraint
%type<TypeValue>    ParseAtNotationList
%type<TypeValue>    ParseAtNotation
%type<TypeValue>    ParseComponentIdList
%type<TypeValue>    ParseLevel
%type<TypeValue>    ParseExceptionIdentification
%type<TypeValue>    ParseNamedType
%type<TypeValue>    ParseNamedBitList
%type<TypeValue>    ParseNamedBit
%type<TypeValue>    ParseRestrictedCharacterStringType
%type<TypeValue>    ParseUnrestrictedCharacterStringType
%type<TypeValue>    ParseAlternativeTypeLists
%type<TypeValue>    ParseRootAlternativeTypeList
%type<TypeValue>    ParseExtensionAndException
%type<TypeValue>    ParseExtensionAdditionAlternatives
%type<TypeValue>    ParseOptionalExtensionMarker
%type<TypeValue>    ParseAlternativeTypeList
%type<TypeValue>    ParseExtensionAdditionAlternativesList
%type<TypeValue>    ParseExtensionAdditionAlternative
%type<TypeValue>    ParseExtensionAdditionAlternativesGroup
%type<TypeValue>    ParseEnumerations
%type<TypeValue>    ParseVersionNumber
%type<TypeValue>    ParseRootEnumeration
%type<TypeValue>    ParseAdditionalEnumeration
%type<TypeValue>    ParseEnumeration
%type<TypeValue>    ParseEnumerationItem
%type<TypeValue>    ParseNamedNumber
%type<TypeValue>    ParseNamedNumberList
%type<TypeValue>    ParseComponentTypeLists
%type<TypeValue>    ParseRootComponentTypeList
%type<TypeValue>    ParseExtensionAdditions
%type<TypeValue>    ParseExtensionEndMarker
%type<TypeValue>    ParseComponentTypeList
%type<TypeValue>    ParseComponentType
%type<TypeValue>    ParseExtensionAdditionList
%type<TypeValue>    ParseExtensionAddition
%type<TypeValue>    ParseExtensionAdditionGroup
%type<TypeValue>    ParseTaggedType
%type<TypeValue>    ParseEncodingPrefixedType
%type<TypeValue>    ParseAssignementSymbol
%type<TypeValue>    ParseString
%type<TypeValue>    ParseNumber
%type<TypeValue>    ParseBoolean
%type<TypeValue>    ParseBlock

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
            $2,
        }
    }
  | CURLY_START ParseActualParameterList COMMA ParseActualParameter CURLY_END {
        $$ = $2
        $$ = append($$.(LIST), $4)
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

/******************************************************************************
 * BNF Definition:
 * ExternalObjectReference ::=
 *      modulereference "." objectreference
 *****************************************************************************/
ParseExternalObjectReference:
    ParseString DOT ParseString {
        $$ = MAP {
            "moduleReference": $1,
            "objectReference": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedObject ::=
 *      DefinedObject ActualParameterList
 *****************************************************************************/
ParseParameterizedObject:
    ParseDefinedObject ParseActualParameterList {
        $$ = MAP {
            "definedObject":       $1,
            "actualParameterList": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * DefinedObjectSet ::=
 *      ExternalObjectSetReference | objectsetreference
 *****************************************************************************/
ParseDefinedObjectSet:
    ParseExternalObjectSetReference {
        $$ = $1
    }
  | ParseString {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ExternalObjectSetReference ::=
 *      modulereference "." objectsetreference
 *****************************************************************************/
ParseExternalObjectSetReference:
    ParseString DOT ParseString {
        $$ = MAP {
            "moduleReference":    $1,
            "objectSetReference": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ParameterizedObjectSet ::=
 *      DefinedObjectSet ActualParameterList
 *****************************************************************************/
ParseParameterizedObjectSet:
    ParseDefinedObjectSet ParseActualParameterList {
        $$ = MAP {
            "definedObjectSet":    $1,
            "actualParameterList": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * FieldName ::=
 *     PrimitiveFieldName "." +
 *****************************************************************************/
ParseFieldName:
    ParsePrimitiveFieldNameList {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * PrimitiveFieldNameList ::=
 *     PrimitiveFieldName
 *     | PrimitiveFieldNameList "." PrimitiveFieldName
 *****************************************************************************/
 ParsePrimitiveFieldNameList:
    ParsePrimitiveFieldName {
        $$ = LIST {
            $1,
        }
    }
  | ParsePrimitiveFieldNameList DOT ParsePrimitiveFieldName {
        $$ = $1
        $$ = append($$.(LIST), $3)
     }

/******************************************************************************
 * BNF Definition:
 * PrimitiveFieldName ::=
 *      typefieldreference
 *      | valuefieldreference
 *      | valuesetfieldreference
 *      | objectfieldreference
 *      | objectsetfieldreference
 *****************************************************************************/
ParsePrimitiveFieldName:
    ParseString {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ValueSetFromObjects ::=
 *     ReferencedObjects "." FieldName
 *****************************************************************************/
ParseValueSetFromObjects:
    ParseReferencedObjects DOT ParseFieldName {
        $$ = MAP {
            "referencedObjects": $1,
            "fieldname":         $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ConstrainedType ::=
 *      Type Constraint
 *      | TypeWithConstraint
 *****************************************************************************/
ParseConstrainedType:
    ParseType ParseConstraint {
        $$ = MAP {
            "type":       $1,
            "constraint": $2,
        }
    }
  | ParseTypeWithConstraint {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * Constraint ::=
 *      "(" ConstraintSpec ExceptionSpec ")"
 *****************************************************************************/
ParseConstraint:
    ROUND_START ParseConstraintSpec ParseExceptionSpec ROUND_END {
        $$ = MAP {
            "constraintSpec": $2,
            "exceptionSpec":  $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ConstraintSpec ::=
 *      SubtypeConstraint
 *       | GeneralConstraint
 *****************************************************************************/
ParseConstraintSpec:
    ParseSubtypeConstraint {
        $$ = MAP {
            "subtypeConstraint": $1,
        }
    }
  | ParseGeneralConstraint {
        $$ = MAP {
            "generalConstraint": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SubtypeConstraint ::=
 *      ElementSetSpecs
 *****************************************************************************/
ParseSubtypeConstraint:
    ParseElementSetSpecs {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ElementSetSpecs ::=
 *      RootElementSetSpec
 *      | RootElementSetSpec "," "..."
 *      | RootElementSetSpec "," "..." "," AdditionalElementSetSpec
 *****************************************************************************/
ParseElementSetSpecs:
    ParseRootElementSetSpec {
        $$ = MAP {
            "rootElementSetSpec": $1,
        }
    }
  | ParseRootElementSetSpec COMMA ELLIPSIS {
        $$ = MAP {
            "rootElementSetSpec": $1,
        }
    }
  | ParseRootElementSetSpec COMMA ELLIPSIS COMMA ParseAdditionalElementSetSpec {
        $$ = MAP {
            "rootElementSetSpec":       $1,
            "additionalElementSetSpec": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * RootElementSetSpec ::=
 *      ElementSetSpec
 *****************************************************************************/
ParseRootElementSetSpec:
    ParseElementSetSpec {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * AdditionalElementSetSpec ::=
 *      ElementSetSpec
 *****************************************************************************/
ParseAdditionalElementSetSpec:
    ParseElementSetSpec {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ElementSetSpec ::=
 *      Unions
 *      | ALL Exclusions
 *****************************************************************************/
ParseElementSetSpec:
    ParseUnions {
        $$ = MAP {
            "unions": $1,
        }
    }
  | ALL_SYMBOL ParseExclusions {
        $$ = MAP {
            "exclusions": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Unions ::=
 *      Intersections
 *      | UElems UnionMark Intersections
 *****************************************************************************/
ParseUnions:
    ParseIntersections {
        $$ = $1
    }
  | ParseUElems ParseUnionMark ParseIntersections {
        $$ = MAP {
            "unions":        $1,
            "intersections": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Intersections ::=
 *      IntersectionElements
 *      | IElems IntersectionMark IntersectionElements
 *****************************************************************************/
ParseIntersections:
    ParseIntersectionElements {
        $$ = $1
    }
  | ParseIElems ParseIntersectionMark ParseIntersectionElements {
        $$ = MAP {
            "intersections":        $1,
            "intersectionElements": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * IntersectionElements ::=
 *      Elements | Elems Exclusions
 *****************************************************************************/
ParseIntersectionElements:
    ParseElements {
        $$ = $1
    }
  | ParseElems ParseExclusions {
        $$ = MAP {
            "elements":   $1,
            "exclusions": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Elements ::=
 *      SubtypeElements
 *      | ObjectSetElements
 *      | "(" ElementSetSpec ")"
 *****************************************************************************/
ParseElements:
    ParseSubtypeElements {
        $$ = MAP {
            "subtypeElements": $1,
        }
    }
  | ParseObjectSetElements {
        $$ = MAP {
            "objectSetElements": $1,
        }
    }
  | ROUND_START ParseElementSetSpec ROUND_END {
        $$ = MAP {
            "elementSetSpec": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Elems ::=
 *      Elements
 *****************************************************************************/
ParseElems:
    ParseElements {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * SubtypeElements ::=
 *      SingleValue
 *      | ContainedSubtype
 *      | ValueRange
 *      | PermittedAlphabet
 *      | SizeConstraint
 *      | TypeConstraint
 *      | InnerTypeConstraints
 *      | PatternConstraint
 *      | PropertySettings
 *      | DurationRange
 *      | TimePointRange
 *      | RecurrenceRange
 *****************************************************************************/
ParseSubtypeElements:
    ParseSingleValue {
        $$ = MAP {
            "singleValue": $1,
        }
    }
  | ParseContainedSubtype {
        $$ = MAP {
            "containedSubtype": $1,
        }
    }
  | ParseValueRange {
        $$ = MAP {
            "valueRange": $1,
        }
    }
  | ParsePermittedAlphabet {
        $$ = MAP {
            "permittedAlphabet": $1,
        }
    }
  | ParseSizeConstraint {
        $$ = MAP {
            "sizeConstraint": $1,
        }
    }
  | ParseTypeConstraint {
        $$ = MAP {
            "typeConstraint": $1,
        }
    }
  | ParseInnerTypeConstraints {
        $$ = MAP {
            "innerTypeConstraints": $1,
        }
    }
  | ParsePatternConstraint {
        $$ = MAP {
            "patternConstraint": $1,
        }
    }
  | ParsePropertySettings {
        $$ = MAP {
            "propertySettings": $1,
        }
    }
  | ParseDurationRange {
        $$ = MAP {
            "durationRange": $1,
        }
    }
  | ParseTimePointRange {
        $$ = MAP {
            "timePointRange": $1,
        }
    }
  | ParseRecurrenceRange {
        $$ = MAP {
            "recurrenceRange": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SingleValue ::=
 *      ParseValue
 *****************************************************************************/
ParseSingleValue:
    ParseValue {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ContainedSubtype ::=
 *      Includes Type
 *****************************************************************************/
ParseContainedSubtype:
    ParseIncludes ParseType {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * Includes ::=
 *      INCLUDES | empty
 *****************************************************************************/
ParseIncludes:
    INCLUDES_SYMBOL {
        $$ = "INCLUDES"
    }
  | /* EMPTY */ {
        $$ = "INCLUDES"
    }

/******************************************************************************
 * BNF Definition:
 * ValueRange ::=
 *      LowerEndpoint ".." UpperEndpoint
 *****************************************************************************/
ParseValueRange:
    ParseLowerEndpoint DOT DOT ParseUpperEndpoint {
        $$ = MAP {
            "lowerEndpoint": $1,
            "upperEndpoint": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * LowerEndpoint ::=
 *      LowerEndValue | LowerEndValue "<"
 *****************************************************************************/
ParseLowerEndpoint:
    ParseLowerEndValue {
        $$ = $1
    }
  | ParseLowerEndValue LESS_THAN {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * LowerEndValue ::=
 *      Value | MIN
 *****************************************************************************/
ParseLowerEndValue:
    ParseValue {
        $$ = $1
    }
  | MIN_SYMBOL {
        $$ = "MIN"
    }

/******************************************************************************
 * BNF Definition:
 * UpperEndpoint ::=
 *      UpperEndValue | "<" UpperEndValue
 *****************************************************************************/
ParseUpperEndpoint:
    ParseUpperEndValue {
        $$ = $1
    }
  | LESS_THAN ParseUpperEndValue {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * UpperEndValue ::=
 *      Value | MAX
 *****************************************************************************/
ParseUpperEndValue:
    ParseValue {
        $$ = $1
    }
  | MAX_SYMBOL {
        $$ = "MAX"
    }

/******************************************************************************
 * BNF Definition:
 * PermittedAlphabet ::=
 *      FROM Constraint
 *****************************************************************************/
ParsePermittedAlphabet:
    FROM_SYMBOL ParseConstraint {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * SizeConstraint ::=
 *      SIZE Constraint
 *****************************************************************************/
ParseSizeConstraint:
    SIZE_SYMBOL ParseConstraint {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * TypeConstraint ::=
 *      Type
 *****************************************************************************/
ParseTypeConstraint:
    ParseType {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * InnerTypeConstraints ::=
 *      WITH COMPONENT SingleTypeConstraint
 *      | WITH COMPONENTS MultipleTypeConstraints
 *****************************************************************************/
ParseInnerTypeConstraints:
    WITH_SYMBOL COMPONENTS_SYMBOL ParseSingleTypeConstraint {
        $$ = $3
    }
    WITH_SYMBOL COMPONENTS_SYMBOL ParseMultipleTypeConstraints {
        $$ = $3
    }

/******************************************************************************
 * BNF Definition:
 * SingleTypeConstraint::=
 *      Constraint
 *****************************************************************************/
ParseSingleTypeConstraint:
    ParseConstraint {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * MultipleTypeConstraints ::=
 *      FullSpecification
 *      | PartialSpecification
 *****************************************************************************/
ParseMultipleTypeConstraints:
    ParseFullSpecification {
        $$ = $1
    }
  | ParsePartialSpecification {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * FullSpecification ::=
 *      "{" TypeConstraints "}"
 *****************************************************************************/
ParseFullSpecification:
    CURLY_START ParseTypeConstraints CURLY_END {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * TypeConstraints ::=
 *      NamedConstraint
 *      | NamedConstraint "," TypeConstraints
 *****************************************************************************/
ParseTypeConstraints:
    ParseNamedConstraint {
        $$ = $1
    }
  | ParseNamedConstraint COMMA ParseTypeConstraints {
        $$ = MAP {
            "nameConstraint":  $1,
            "typeConstraints": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NamedConstraint ::=
 *      identifier ComponentConstraint
 *****************************************************************************/
ParseNamedConstraint:
    ParseString ParseComponentConstraint {
        $$ = MAP {
            "identifier":          $1,
            "componentConstraint": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ComponentConstraint ::=
 *      ValueConstraint PresenceConstraint
 *****************************************************************************/
ParseComponentConstraint:
    ParseValueConstraint ParsePresenceConstraint {
        $$ = MAP {
            "valueConstraint":    $1,
            "presenceConstraint": $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ValueConstraint ::=
 *      Constraint | empty
 *****************************************************************************/
ParseValueConstraint:
    ParseConstraint {
        $$ = $1
    }
 |  /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * PresenceConstraint ::=
 *      PRESENT | ABSENT | OPTIONAL | empty
 *****************************************************************************/
ParsePresenceConstraint:
    PRESENT_SYMBOL {
        $$ = "PRESENT"
    }
  | ABSENT_SYMBOL {
        $$ = "ABSENT"
    }
  | OPTIONAL_SYMBOL {
        $$ = "OPTIONAL"
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * PartialSpecification ::=
 *      "{" "..." "," TypeConstraints "}"
 *****************************************************************************/
ParsePartialSpecification:
    CURLY_START ELLIPSIS COMMA ParseTypeConstraints CURLY_END {
        $$ = $4
    }

/******************************************************************************
 * BNF Definition:
 * PatternConstraint ::=
 *      PATTERN Value
 *****************************************************************************/
ParsePatternConstraint:
    PATTERN_SYMBOL ParseValue {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * PropertySettings ::=
 *      SETTINGS simplestring
 *****************************************************************************/
ParsePropertySettings:
    SETTINGS_SYMBOL ParseString {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * DurationRange ::=
 *      ValueRange
 *****************************************************************************/
ParseDurationRange:
    ParseValueRange {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * TimePointRange ::=
 *      ValueRange
 *****************************************************************************/
ParseTimePointRange:
    ParseValueRange {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * RecurrenceRange ::=
 *      ValueRange
 *****************************************************************************/
ParseRecurrenceRange:
    ParseValueRange {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ObjectSetElements ::=
 *      Object
 *      | DefinedObjectSet
 *      | ObjectSetFromObjects
 *      | ParameterizedObjectSet
 *****************************************************************************/
ParseObjectSetElements:
    ParseObject{
        $$ = MAP {
            "object": $1,
        }
    }
  | ParseDefinedObjectSet {
        $$ = MAP {
            "definedObjectSet": $1,
        }
    }
  | ParseObjectSetFromObjects {
        $$ = MAP {
            "objectSetFromObjects": $1,
        }
    }
  | ParseParameterizedObjectSet {
        $$ = MAP {
            "parameterizedObjectSet": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectSetFromObjects ::=
 *      ReferencedObjects "." FieldName
 *****************************************************************************/
ParseObjectSetFromObjects:
    ParseReferencedObjects DOT ParseFieldName {
        $$ = MAP {
            "referencedObjects": $1,
            "fieldName":         $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * IElems ::=
 *      Intersections
 *****************************************************************************/
ParseIElems:
    ParseIntersections {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * IntersectionMark ::=
 *      "^" | INTERSECTION
 *****************************************************************************/
ParseIntersectionMark:
    CARET {
        $$ = "INTERSECTION"
    }
  | INTERSECTION_SYMBOL {
        $$ = "INTERSECTION"
    }

/******************************************************************************
 * BNF Definition:
 * UElems ::=
 *      Unions
 *****************************************************************************/
ParseUElems:
    ParseUnions {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * UnionMark ::=
 *      "|" | UNION
 *****************************************************************************/
ParseUnionMark:
    PIPE {
        $$ = "UNION"
    }
  | UNION_SYMBOL {
        $$ = "UNION"
    }

/******************************************************************************
 * BNF Definition:
 * Exclusions ::=
 *      EXCEPT Elements
 *****************************************************************************/
ParseExclusions:
    EXCEPT_SYMBOL ParseElements {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * GeneralConstraint ::=
 *      UserDefinedConstraint
 *      | TableConstraint
 *      | ContentsConstraint
 *****************************************************************************/
ParseGeneralConstraint:
    ParseUserDefinedConstraint {
        $$ = MAP {
            "userDefinedConstraint": $1,
        }
    }
  | ParseTableConstraint {
        $$ = MAP {
            "tableConstraint": $1,
        }
    }
  | ParseContentsConstraint {
        $$ = MAP {
            "contentsConstraint": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * UserDefinedConstraint ::=
 *      CONSTRAINED BY "{" UserDefinedConstraintParameter "," * "}"
 *****************************************************************************/
ParseUserDefinedConstraint:
    CONSTRAINED_SYMBOL BY_SYMBOL CURLY_START ParseUserDefinedConstraintParameterList CURLY_END {
        $$ = $4
    }

/******************************************************************************
 * BNF Definition:
 * UserDefinedConstraintParameterList ::=
 *      UserDefinedConstraintParameter
 *      | UserDefinedConstraintParameterList "," UserDefinedConstraintParameter
 *      | empty
 *****************************************************************************/
ParseUserDefinedConstraintParameterList:
    ParseUserDefinedConstraintParameter {
        $$ = LIST {
            $1,
        }
    }
  | ParseUserDefinedConstraintParameterList COMMA ParseUserDefinedConstraintParameter {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * UserDefinedConstraintParameter ::=
 *      Governor ":" Value
 *      | Governor ":" Object
 *      | DefinedObjectSet
 *      | Type
 *      | DefinedObjectClass
 *****************************************************************************/
ParseUserDefinedConstraintParameter:
    ParseGovernor COLON ParseValue {
        $$ = MAP {
            "governor": $1,
            "value":    $3,
        }
    }
  | ParseGovernor COLON ParseObject {
        $$ = MAP {
            "governor": $1,
            "object":   $3,
        }
    }
  | ParseDefinedObjectSet {
        $$ = MAP {
            "definedObjectSet": $1,
        }
    }
  | ParseType {
        $$ = MAP {
            "type": $1,
        }
    }
  | ParseDefinedObjectClass {
        $$ = MAP {
            "definedObjectClass": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Governor ::=
 *      Type | DefinedObjectClass
 *****************************************************************************/
ParseGovernor:
    ParseType {
        $$ = MAP {
            "type": $1,
        }
    }
  | ParseDefinedObjectClass {
        $$ = MAP {
            "definedObjectClass": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TableConstraint ::=
 *      SimpleTableConstraint | ComponentRelationConstraint
 *****************************************************************************/
ParseTableConstraint:
    ParseSimpleTableConstraint{
        $$ = MAP{
            "simpleTableConstraint": $1,
        }
    }
  | ParseComponentRelationConstraint {
        $$ = MAP{
            "componentRelationConstraint": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SimpleTableConstraint ::=
 *      ObjectSet
 *****************************************************************************/
ParseSimpleTableConstraint:
    ParseObjectSet {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ComponentRelationConstraint ::=
 *      "{" DefinedObjectSet "}" "{" AtNotation "," + "}"
 *****************************************************************************/
ParseComponentRelationConstraint:
    CURLY_START ParseDefinedObjectSet CURLY_END CURLY_START ParseAtNotationList CURLY_END
    /* EMPTY */ {
        $$ = MAP {
            "definedObjectSet": $1,
            "atNotations":      $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * AtNotationList ::=
 *      AtNotation
 *      AtNotationList "," AtNotation
 *****************************************************************************/
ParseAtNotationList:
    ParseAtNotation {
        $$ = LIST {
            $1,
        }
    }
  | ParseAtNotationList COMMA ParseAtNotation {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * AtNotation ::=
 *      "@" ComponentIdList | "@." Level ComponentIdList
 *****************************************************************************/
ParseAtNotation:
    AT_THE_RATE ParseComponentIdList {
        $$ = MAP {
            "componentIdList": $2,
        }
    }
  | AT_THE_RATE DOT ParseLevel ParseComponentIdList {
        $$ = MAP {
            "componentIdList": $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ComponentIdList ::=
 *      identifier "." +
 *****************************************************************************/
ParseComponentIdList:
    ParseString {
        $$ = LIST {
            $1,
        }
    }
  | ParseComponentIdList DOT ParseString {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * Level ::=
 *      "." Level | empty
 *****************************************************************************/
ParseLevel:
    DOT ParseLevel {
        $$ = nil
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ContentsConstraint ::=
 *      CONTAINING Type
 *      | ENCODED BY Value
 *      | CONTAINING Type ENCODED BY Value
 *****************************************************************************/
ParseContentsConstraint:
    CONTAINING_SYMBOL ParseType {
        $$ = MAP {
            "type": $2,
        }
    }
  | ENCODED_SYMBOL BY_SYMBOL ParseValue {
        $$ = MAP {
            "value": $3,
        }
    }
  | CONTAINING_SYMBOL ParseType ENCODED_SYMBOL BY_SYMBOL ParseValue {
        $$ = MAP {
            "type":  $2,
            "value": $5,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExceptionSpec ::=
 *      "!" ExceptionIdentification | empty
 *****************************************************************************/
ParseExceptionSpec:
    EXCLAMATION ParseExceptionIdentification {
        $$ = MAP {
            "exceptionIdentification": $1,
        }
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ExceptionIdentification ::=
 *      SignedNumber
 *      | DefinedValue
 *      | Type ":" Value
 *****************************************************************************/
ParseExceptionIdentification:
    ParseNumber {
        $$ = $1
    }
  | ParseDefinedValue {
        $$ = $1
    }
  | ParseType COLON ParseValue {
        $$ = MAP {
            "type":  $1,
            "value": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TypeWithConstraint ::=
 *      SET Constraint OF Type
 *      | SET SizeConstraint OF Type
 *      | SEQUENCE Constraint OF Type
 *      | SEQUENCE SizeConstraint OF Type
 *      | SET Constraint OF NamedType
 *      | SET SizeConstraint OF NamedType
 *      | SEQUENCE Constraint OF NamedType
 *      | SEQUENCE SizeConstraint OF NamedType
 *****************************************************************************/
ParseTypeWithConstraint:
    SET_SYMBOL ParseConstraint OF_SYMBOL ParseType {
        $$ = MAP {
            "setOrSequence": "SET",
            "constraint":    $2,
            "type":          $4,
        }
    }
  | SET_SYMBOL ParseSizeConstraint OF_SYMBOL ParseType {
        $$ = MAP {
            "setOrSequence":  "SET",
            "sizeConstraint": $2,
            "type":           $4,
        }
    }
  | SEQUENCE_SYMBOL ParseConstraint OF_SYMBOL ParseType {
        $$ = MAP {
            "setOrSequence": "SEQUENCE",
            "constraint":    $2,
            "type":          $4,
        }
    }
  | SEQUENCE_SYMBOL ParseSizeConstraint OF_SYMBOL ParseType {
        $$ = MAP {
            "setOrSequence":  "SEQUENCE",
            "sizeConstraint": $2,
            "type":           $4,
        }
    }
  | SET_SYMBOL ParseConstraint OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "setOrSequence": "SET",
            "constraint":    $2,
            "namedType":     $4,
        }
    }
  | SET_SYMBOL ParseSizeConstraint OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "setOrSequence":  "SET",
            "sizeConstraint": $2,
            "namedType":      $4,
        }
    }
  | SEQUENCE_SYMBOL ParseConstraint OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "setOrSequence": "SEQUENCE",
            "constraint":    $2,
            "namedType":     $4,
        }
    }
  | SEQUENCE_SYMBOL ParseSizeConstraint OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "setOrSequence":  "SEQUENCE",
            "sizeConstraint": $2,
            "namedType":      $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NamedType ::=
 *      identifier Type
 *****************************************************************************/
ParseNamedType:
    ParseString ParseType {
        $$ = MAP {
            "identifier": $1,
            "type":       $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * BitStringType ::=
 *      BIT STRING
 *      | BIT STRING "{" NamedBitList "}"
 *****************************************************************************/
ParseBitStringType:
    BIT_SYMBOL STRING_SYMBOL {
        $$ = MAP {
            "type": "BIT_STRING",
        }
    }
  | BIT_SYMBOL STRING_SYMBOL CURLY_START ParseNamedBitList CURLY_END {
        $$ = MAP {
            "type":      "BIT_STRING",
            "namedBits": $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NamedBitList ::=
 *      NamedBit
 *      | NamedBitList "," NamedBit
 *****************************************************************************/
ParseNamedBitList:
    ParseNamedBit {
        $$ = LIST {
            $1,
        }
    }
  | ParseNamedBitList COMMA ParseNamedBit {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * NamedBit ::=
 *      identifier "(" number ")"
 *      | identifier "(" DefinedValue ")"
 *****************************************************************************/
ParseNamedBit:
    ParseString ROUND_START ParseNumber ROUND_END {
        $$ = MAP {
            "identifier": $1,
            "number":     $3,
        }
    }
  | ParseString ROUND_START ParseDefinedValue ROUND_END {
        $$ = MAP {
            "identifier":   $1,
            "definedValue": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * BooleanType ::=
 *      BOOLEAN
 *****************************************************************************/
ParseBooleanType:
    BOOLEAN_SYMBOL {
        $$ = MAP {
            "type": "BOOLEAN",
        }
    }

/******************************************************************************
 * BNF Definition:
 * CharacterStringType ::=
 *      RestrictedCharacterStringType
 *      | UnrestrictedCharacterStringType
 *****************************************************************************/
ParseCharacterStringType:
    ParseRestrictedCharacterStringType {
        $$ = $1
    }
  | ParseUnrestrictedCharacterStringType {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * RestrictedCharacterStringType ::=
 *      BMPString
 *      | GeneralString
 *      | GraphicString
 *      | IA5String
 *      | ISO646String
 *      | NumericString
 *      | PrintableString
 *      | TeletexString
 *      | T61String
 *      | UniversalString
 *      | UTF8String
 *      | VideotexString
 *      | VisibleString
 *****************************************************************************/
ParseRestrictedCharacterStringType:
    BMPSTRING_SYMBOL {
        $$ = MAP {
            "type": "BMP_STRING",
        }
    }
  | GENERALSTRING_SYMBOL {
        $$ = MAP {
            "type": "GENERAL_STRING",
        }
    }
  | GRAPHICSTRING_SYMBOL {
        $$ = MAP {
            "type": "GRAPHIC_STRING",
        }
    }
  | IA5STRING_SYMBOL {
        $$ = MAP {
            "type": "IA5_STRING",
        }
    }
  | ISO646STRING_SYMBOL {
        $$ = MAP {
            "type": "ISO646_STRING",
        }
    }
  | NUMERICSTRING_SYMBOL {
        $$ = MAP {
            "type": "NUMERIC_STRING",
        }
    }
  | PRINTABLESTRING_SYMBOL {
        $$ = MAP {
            "type": "PRINTABLE_STRING",
        }
    }
  | TELETEXSTRING_SYMBOL {
        $$ = MAP {
            "type": "TELETEX_STRING",
        }
    }
  | T61STRING_SYMBOL {
        $$ = MAP {
            "type": "T61_STRING",
        }
    }
  | UNIVERSALSTRING_SYMBOL {
        $$ = MAP {
            "type": "UNIVERSAL_STRING",
        }
    }
  | UTF8STRING_SYMBOL {
        $$ = MAP {
            "type": "UTF8_STRING",
        }
    }
  | VIDEOTEXSTRING_SYMBOL {
        $$ = MAP {
            "type": "VIDEO_TEX_STRING",
        }
    }
  | VISIBLESTRING_SYMBOL {
        $$ = MAP {
            "type": "VISIBLE_STRING",
        }
    }

/******************************************************************************
 * BNF Definition:
 * UnrestrictedCharacterStringType ::=
 *      CHARACTER STRING
 *****************************************************************************/
ParseUnrestrictedCharacterStringType:
    CHARACTER_SYMBOL STRING_SYMBOL {
        $$ = MAP {
            "type": "CHARACTER_STRING",
        }
    }

/******************************************************************************
 * BNF Definition:
 * ChoiceType ::=
 *      CHOICE "{" AlternativeTypeLists "}"
 *****************************************************************************/
ParseChoiceType:
    CHOICE_SYMBOL CURLY_START ParseAlternativeTypeLists CURLY_END {
        $$ = MAP {
            "type":           "CHOICE",
            "alternateTypes": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * AlternativeTypeLists ::=
 *      RootAlternativeTypeList
 *      | RootAlternativeTypeList "," ExtensionAndException ExtensionAdditionAlternatives OptionalExtensionMarker
 *****************************************************************************/
ParseAlternativeTypeLists:
    ParseRootAlternativeTypeList {
        $$ = MAP {
            "alternativeTypes": $1,
        }
    }
  | ParseRootAlternativeTypeList COMMA ParseExtensionAndException ParseExtensionAdditionAlternatives ParseOptionalExtensionMarker {
        $$ = MAP {
            "alternativeTypes":              $1,
            "extensionAndException":         $3,
            "extensionAdditionAlternatives": $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * RootAlternativeTypeList ::=
 *      AlternativeTypeList
 *****************************************************************************/
ParseRootAlternativeTypeList:
    ParseAlternativeTypeList {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * AlternativeTypeList ::=
 *       NamedType
 *       | AlternativeTypeList "," NamedType
 *****************************************************************************/
ParseAlternativeTypeList:
    ParseNamedType {
        $$ = LIST {
            $1,
        }
    }
  | ParseAlternativeTypeList COMMA ParseNamedType {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAndException ::=
 *      "..."
 *      | "..." ExceptionSpec
 *****************************************************************************/
ParseExtensionAndException:
    ELLIPSIS {
        $$ = nil
    }
  | ELLIPSIS  ParseExceptionSpec {
        $$ = $2
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionAlternatives ::=
 *      "," ExtensionAdditionAlternativesList
 *      | empty
 *****************************************************************************/
ParseExtensionAdditionAlternatives:
    COMMA ParseExtensionAdditionAlternativesList {
        $$ = $2
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionAlternativesList ::=
 *      ExtensionAdditionAlternative
 *      | ExtensionAdditionAlternativesList "," ExtensionAdditionAlternative
 *****************************************************************************/
ParseExtensionAdditionAlternativesList:
    ParseExtensionAdditionAlternative {
        $$ = LIST {
            $1,
        }
    }
  | ParseExtensionAdditionAlternativesList COMMA ParseExtensionAdditionAlternative {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionAlternative ::=
 *      ExtensionAdditionAlternativesGroup
 *      | NamedType
 *****************************************************************************/
ParseExtensionAdditionAlternative:
    ParseExtensionAdditionAlternativesGroup {
        $$ = $1
    }
  | ParseNamedType {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionAlternativesGroup ::=
 *      "[[" VersionNumber AlternativeTypeList "]]"
 *****************************************************************************/
ParseExtensionAdditionAlternativesGroup:
    SQUARE_START SQUARE_START ParseVersionNumber ParseAlternativeTypeList SQUARE_END SQUARE_END {
        $$ = MAP {
            "version":          $3,
            "alternativeTypes": $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * VersionNumber ::=
 *      empty | number ":"
 *****************************************************************************/
ParseVersionNumber:
    ParseNumber COLON {
        $$ = $1
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * OptionalExtensionMarker ::=
 *      "," "..."
 *      | empty
 *****************************************************************************/
ParseOptionalExtensionMarker:
    COMMA ELLIPSIS {
        $$ = true
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * DateType ::=
 *      DATE
 *****************************************************************************/
ParseDateType:
    DATE_SYMBOL {
        $$ = MAP {
            "type": "DATE",
        }
    }

/******************************************************************************
 * BNF Definition:
 * DateTimeType ::=
 *      DATE-TIME
 *****************************************************************************/
ParseDateTimeType:
    DATETIME_SYMBOL {
        $$ = MAP {
            "type": "DATE_TIME",
        }
    }

/******************************************************************************
 * BNF Definition:
 * DurationType ::=
 *      DURATION
 *****************************************************************************/
ParseDurationType:
    DURATION_SYMBOL {
        $$ = MAP {
            "type": "DURATION",
        }
    }

/******************************************************************************
 * BNF Definition:
 * EmbeddedPDVType ::=
 *      EMBEDDED PDV
 *****************************************************************************/
ParseEmbeddedPDVType:
    EMBEDDED_SYMBOL PDV_SYMBOL {
        $$ = MAP {
            "type": "EMBEDDED_PDV",
        }
    }

/******************************************************************************
 * BNF Definition:
 * EnumeratedType ::=
 *      ENUMERATED "{" Enumerations "}"
 *****************************************************************************/
ParseEnumeratedType:
    ENUMERATED_SYMBOL CURLY_START ParseEnumerations CURLY_END {
        $$ = MAP {
            "type":         "ENUMERATED",
            "enumerations": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * Enumerations ::=
 *      RootEnumeration
 *      | RootEnumeration "," "..." ExceptionSpec
 *      | RootEnumeration "," "..." ExceptionSpec "," AdditionalEnumeration
 *****************************************************************************/
ParseEnumerations:
    ParseRootEnumeration {
        $$ = MAP {
            "enumeration": $1,
        }
    }
  | ParseRootEnumeration COMMA ELLIPSIS ParseExceptionSpec {
        $$ = MAP {
            "enumeration": $1,
            "exception":   $4,
        }
    }
  | ParseRootEnumeration COMMA ELLIPSIS ParseExceptionSpec COMMA ParseAdditionalEnumeration {
        $$ = MAP {
            "enumeration":           $1,
            "exception":             $4,
            "additionalEnumeration": $6,
        }
    }

/******************************************************************************
 * BNF Definition:
 * RootEnumeration ::=
 *      Enumeration
 *****************************************************************************/
ParseRootEnumeration:
    ParseEnumeration {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * AdditionalEnumeration ::=
 *      Enumeration
 *****************************************************************************/
ParseAdditionalEnumeration:
    ParseEnumeration {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * Enumeration ::=
 *      EnumerationItem
 *      | EnumerationItem "," Enumeration
 *****************************************************************************/
ParseEnumeration:
    ParseEnumerationItem {
        $$ = LIST {
            $1,
        }
    }
  | ParseEnumeration COMMA ParseEnumerationItem {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * EnumerationItem ::=
 *      identifier | NamedNumber
 *****************************************************************************/
ParseEnumerationItem:
    ParseString {
        $$ = MAP {
            "name": $1,
        }
    }
  | ParseNamedNumber {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * NamedNumber ::=
 *      identifier "(" SignedNumber ")"
 *      | identifier "(" DefinedValue ")"
 *****************************************************************************/
ParseNamedNumber:
    ParseString ROUND_START ParseNumber ROUND_END
    /* EMPTY */ {
        $$ = MAP {
            "name":   $1,
            "number": $3,
        }
    }
  | ParseString ROUND_START ParseDefinedValue ROUND_END {
        $$ = MAP {
            "name":         $1,
            "definedValue": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExternalType ::=
 *      EXTERNAL
 *****************************************************************************/
ParseExternalType:
    EXTERNEL_SYMBOL {
        $$ = MAP {
            "type": "EXTERNAL",
        }
    }

/******************************************************************************
 * BNF Definition:
 * InstanceOfType ::=
 *      INSTANCE OF DefinedObjectClass
 *****************************************************************************/
ParseInstanceOfType:
    INSTANCE_SYMBOL OF_SYMBOL ParseDefinedObjectClass {
        $$ = MAP {
            "type":               "INSTANCE_OF",
            "definedObjectClass": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * IntegerType ::=
 *      INTEGER
 *      | INTEGER "{" NamedNumberList "}"
 *****************************************************************************/
ParseIntegerType:
    INTEGER_SYMBOL {
        $$ = MAP {
            "type": "INTEGER",
        }
    }
  | INTEGER_SYMBOL CURLY_START ParseNamedNumberList CURLY_END {
        $$ = MAP {
            "type":    "INTEGER",
            "numbers": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * NamedNumberList ::=
 *      NamedNumber
 *      | NamedNumberList "," NamedNumber
 *****************************************************************************/
ParseNamedNumberList:
    ParseNamedNumber {
        $$ = LIST {
            $1,
        }
    }
  | ParseNamedNumberList COMMA ParseNamedNumber {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * IRIType ::=
 *      OID-IRI
 *****************************************************************************/
ParseIRIType:
    OIDIRI_SYMBOL {
        $$ = MAP {
            "type": "OID_IRI",
        }
    }

/******************************************************************************
 * BNF Definition:
 * NullType ::=
 *      NULL
 *****************************************************************************/
ParseNullType:
    NULL_SYMBOL {
        $$ = MAP {
            "type": "NULL",
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectClassFieldType ::=
 *      DefinedObjectClass "." FieldName
 *****************************************************************************/
ParseObjectClassFieldType:
    ParseDefinedObjectClass DOT ParseFieldName {
        $$ = MAP {
            "type":               "OBJECT_FIELD",
            "definedObjectClass": $1,
            "fieldName":          $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ObjectIdentifierType ::=
 *      OBJECT IDENTIFIER
 *****************************************************************************/
ParseObjectIdentifierType:
    OBJECT_SYMBOL IDENTIFIER_SYMBOL {
        $$ = MAP {
            "type": "OBJECT_IDENTIFIER",
        }
    }

/******************************************************************************
 * BNF Definition:
 * OctetStringType ::=
 *      OCTET STRING
 *****************************************************************************/
ParseOctetStringType:
    OCTET_SYMBOL STRING_SYMBOL {
        $$ = MAP {
            "type": "OCTET_STRING",
        }
    }

/******************************************************************************
 * BNF Definition:
 * RealType ::=
 *      REAL
 *****************************************************************************/
ParseRealType:
    REAL_SYMBOL {
        $$ = MAP {
            "type": "REAL",
        }
    }

/******************************************************************************
 * BNF Definition:
 * RelativeIRIType ::=
 *      RELATIVE-OID-IRI
 *****************************************************************************/
ParseRelativeIRIType:
    RELATIVEOIDIRI_SYMBOL {
        $$ = MAP {
            "type": "RELATIVE_OID_IRI",
        }
    }

/******************************************************************************
 * BNF Definition:
 * RelativeOIDType ::=
 *      RELATIVE-OID
 *****************************************************************************/
ParseRelativeOIDType:
    RELATIVEOID_SYMBOL {
        $$ = MAP {
            "type": "RELATIVE_OID",
        }
    }

/******************************************************************************
 * BNF Definition:
 * SequenceType ::=
 *      SEQUENCE "{" "}"
 *      | SEQUENCE "{" ExtensionAndException OptionalExtensionMarker "}"
 *      | SEQUENCE "{" ComponentTypeLists "}"
 *****************************************************************************/
ParseSequenceType:
    SEQUENCE_SYMBOL CURLY_START CURLY_END {
        $$ = MAP {
            "type": "SEQUENCE",
        }
    }
    SEQUENCE_SYMBOL CURLY_START ParseExtensionAndException ParseOptionalExtensionMarker CURLY_END {
        $$ = MAP {
            "type":                  "SEQUENCE",
            "extensionAndException": $3,
        }
    }
    SEQUENCE_SYMBOL CURLY_START ParseComponentTypeLists CURLY_END {
        $$ = MAP {
            "type":           "SEQUENCE",
            "componentTypes": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ComponentTypeLists ::=
 *      RootComponentTypeList
 *      | RootComponentTypeList "," ExtensionAndException ExtensionAdditions OptionalExtensionMarker
 *      | RootComponentTypeList "," ExtensionAndException ExtensionAdditions ExtensionEndMarker "," RootComponentTypeList
 *      | ExtensionAndException ExtensionAdditions ExensionEndMarker "," RootComponentTypeList
 *      | ExtensionAndException ExtensionAdditions OptionalExtensionMarker
 *****************************************************************************/
ParseComponentTypeLists:
    ParseRootComponentTypeList {
        $$ = MAP {
            "rootComponentTypes":    $1,
        }
    }
  | ParseRootComponentTypeList COMMA ParseExtensionAndException ParseExtensionAdditions ParseOptionalExtensionMarker {
        $$ = MAP {
            "extensionAndException": $3,
            "extensionAdditions":    $4,
            "rootComponentTypes":    $1,
        }
    }
  | ParseRootComponentTypeList COMMA ParseExtensionAndException ParseExtensionAdditions ParseExtensionEndMarker COMMA ParseRootComponentTypeList {
        $$ = MAP {
            "extensionAndException": $3,
            "extensionAdditions":    $4,
            "rootComponentTypes":    append($1.(LIST), $7.(LIST)),
        }
    }
  | ParseExtensionAndException ParseExtensionAdditions ParseExtensionEndMarker COMMA ParseRootComponentTypeList {
        $$ = MAP {
            "extensionAndException": $1,
            "extensionAdditions":    $2,
            "rootComponentTypes":    $5,
        }
    }
  | ParseExtensionAndException ParseExtensionAdditions ParseOptionalExtensionMarker {
        $$ = MAP {
            "extensionAndException": $1,
            "extensionAdditions":    $2,
        }
    }

/******************************************************************************
 * BNF Definition:
 * RootComponentTypeList ::=
 *      ComponentTypeList
 *****************************************************************************/
ParseRootComponentTypeList:
    ParseComponentTypeList {
        $$ = $1
    }

/******************************************************************************
 * BNF Definition:
 * ComponentTypeList ::=
 *      ComponentType
 *      | ComponentTypeList "," ComponentType
 *****************************************************************************/
ParseComponentTypeList:
    ParseComponentType {
        $$ = LIST {
            $1,
        }
    }
  | ParseComponentTypeList COMMA ParseComponentType {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * ComponentType ::=
 *      NamedType
 *      | NamedType OPTIONAL
 *      | NamedType DEFAULT Value
 *      | COMPONENTS OF Type
 *****************************************************************************/
ParseComponentType:
    ParseNamedType {
        $$ = MAP {
            "type":     "COMPONENTS",
            "namedType": $1,
        }
    }
  | ParseNamedType OPTIONAL_SYMBOL {
        $$ = MAP {
            "type":     "COMPONENTS",
            "namedType": $1,
            "optional":  true,
        }
    }
  | ParseNamedType DEFAULT_SYMBOL ParseValue {
        $$ = MAP {
            "type":         "COMPONENTS",
            "namedType":    $1,
            "defaultValue": $3,
        }
    }
  | COMPONENTS_SYMBOL OF_SYMBOL ParseType {
        $$ = MAP {
            "type":     "COMPONENTS",
            "typeName": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionList ::=
 *      ExtensionAddition
 *      | ExtensionAdditionList "," ExtensionAddition
 *****************************************************************************/
ParseExtensionAdditions:
    COMMA ParseExtensionAdditionList {
        $$ = $2
    }
  | /* EMPTY */ {
        $$ = nil
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionList ::=
 *      ExtensionAddition
 *      | ExtensionAdditionList "," ExtensionAddition
 *****************************************************************************/
ParseExtensionAdditionList:
    ParseExtensionAddition {
        $$ = LIST {
            $1,
        }
    }
  | ParseExtensionAdditionList COMMA ParseExtensionAddition {
        $$ = $1
        $$ = append($$.(LIST), $3)
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAddition ::=
 *      ComponentType
 *      | ExtensionAdditionGroup
 *****************************************************************************/
ParseExtensionAddition:
    ParseComponentType {
        $$ = MAP {
            "componentType": $1,
        }
    }
  | ParseExtensionAdditionGroup {
        $$ = MAP {
            "extensionAdditionGroup": $1,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionAdditionGroup ::=
 *      "[[" VersionNumber ComponentTypeList "]]"
 *****************************************************************************/
ParseExtensionAdditionGroup:
    SQUARE_START SQUARE_START ParseVersionNumber ParseComponentTypeList SQUARE_END SQUARE_END {
        $$ = MAP {
            "version":        $3,
            "componentTypes": $4,
        }
    }

/******************************************************************************
 * BNF Definition:
 * ExtensionEndMarker ::=
 *      "," "..."
 *****************************************************************************/
ParseExtensionEndMarker:
    COMMA ELLIPSIS {
        $$ = true
    }

/******************************************************************************
 * BNF Definition:
 * SequenceOfType ::=
 *      SEQUENCE OF Type
 *      | SEQUENCE OF NamedType
 *****************************************************************************/
ParseSequenceOfType:
    SEQUENCE_SYMBOL OF_SYMBOL ParseType {
        $$ = MAP {
            "type":     "SEQUENCE_OF",
            "typeName": $3,
        }
    }
  | SEQUENCE_SYMBOL OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "type":      "SEQUENCE_OF",
            "namedType": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SetType ::=
 *      SET "{" "}"
 *      | SET "{" ExtensionAndException OptionalExtensionMarker "}"
 *      | SET "{" ComponentTypeLists "}"
 *****************************************************************************/
ParseSetType:
    SET_SYMBOL CURLY_START CURLY_END {
        $$ = MAP {
            "type": "SET",
        }
    }
    SET_SYMBOL CURLY_START ParseExtensionAndException ParseOptionalExtensionMarker CURLY_END {
        $$ = MAP {
            "type":                  "SET",
            "extensionAndException": $3,
        }
    }
    SET_SYMBOL CURLY_START ParseComponentTypeLists CURLY_END {
        $$ = MAP {
            "type":           "SET",
            "componentTypes": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * SetOfType ::=
 *      SET OF Type
 *      | SET OF NamedType
 *****************************************************************************/
ParseSetOfType:
    SET_SYMBOL OF_SYMBOL ParseType {
        $$ = MAP {
            "type":     "SET_OF",
            "typeName": $3,
        }
    }
    SET_SYMBOL OF_SYMBOL ParseNamedType {
        $$ = MAP {
            "type":      "SET_OF",
            "namedType": $3,
        }
    }

/******************************************************************************
 * BNF Definition:
 * TimeType ::=
 *      TIME
 *****************************************************************************/
ParseTimeType:
    TIME_SYMBOL {
        $$ = MAP {
            "type": "TIME",
        }
    }

/******************************************************************************
 * BNF Definition:
 * TimeOfDayType ::=
 *      TIME-OF-DAY
 *****************************************************************************/
ParseTimeOfDayType:
    TIMEOFDAY_SYMBOL {
        $$ = MAP {
            "type": "TIME_OF_DAY",
        }
    }

/******************************************************************************
 * BNF Definition:
 * PrefixedType ::=
 *      TaggedType
 *      | EncodingPrefixedType
 *****************************************************************************/
ParsePrefixedType:
    ParseTaggedType {
        $$ = MAP {
            "type":       "PREFIXED",
            "taggedType": $1,
        }
    }
  | ParseEncodingPrefixedType {
        $$ = MAP {
            "type":                 "PREFIXED",
            "encodingPrefixedType": $1,
        }
    }

// TODO
ParseTaggedType:
    /* EMPTY */ {
        $$ = nil
    }

ParseEncodingPrefixedType:
    /* EMPTY */ {
        $$ = nil
    }

// TODO
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

ParseBlock:
    {
        SkipBlock()
    }
    TokenBlock {
        $$ = $2
    }
%%