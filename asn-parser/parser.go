//go:generate goyacc -p ASN asn.y
package main

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"io"
	"regexp"
	"strconv"
	"strings"
	"unicode"
)

const (
	Absent           = "ABSENT"
	AbstractSyntax   = "ABSTRACT-SYNTAX"
	All              = "ALL"
	Application      = "APPLICATION"
	Automatic        = "AUTOMATIC"
	Begin            = "BEGIN"
	Bit              = "BIT"
	BMPString        = "BMPString"
	Boolean          = "BOOLEAN"
	By               = "BY"
	Character        = "CHARACTER"
	Choice           = "CHOICE"
	Class            = "CLASS"
	Component        = "COMPONENT"
	Components       = "COMPONENTS"
	Constrained      = "CONSTRAINED"
	Containing       = "CONTAINING"
	Date             = "DATE"
	DateTime         = "DATE-TIME"
	Default          = "DEFAULT"
	Definitions      = "DEFINITIONS"
	Duration         = "DURATION"
	Embedded         = "EMBEDDED"
	Encoded          = "ENCODED"
	EncodingControl  = "ENCODING-CONTROL"
	End              = "END"
	Enumerated       = "ENUMERATED"
	Except           = "EXCEPT"
	Explicit         = "EXPLICIT"
	Exports          = "EXPORTS"
	Extensibility    = "EXTENSIBILITY"
	Externel         = "EXTERNAL"
	False            = "FALSE"
	From             = "FROM"
	GeneralizedTime  = "GeneralizedTime"
	GeneralString    = "GeneralString"
	GraphicString    = "GraphicString"
	IA5String        = "IA5String"
	Identifier       = "IDENTIFIER"
	Implicit         = "IMPLICIT"
	Implied          = "IMPLIED"
	Imports          = "IMPORTS"
	Includes         = "INCLUDES"
	Instance         = "INSTANCE"
	Instructions     = "INSTRUCTIONS"
	Integer          = "INTEGER"
	Intersection     = "INTERSECTION"
	ISO646String     = "ISO646String"
	Max              = "MAX"
	Min              = "MIN"
	MinusInfinity    = "MINUS-INFINITY"
	NotANumber       = "NOT-A-NUMBER"
	Null             = "NULL"
	NumericString    = "NumericString"
	Object           = "OBJECT"
	ObjectDescriptor = "ObjectDescriptor"
	Octet            = "OCTET"
	Of               = "OF"
	OIDIRI           = "OID-IRI"
	Optional         = "OPTIONAL"
	Pattern          = "PATTERN"
	PDV              = "PDV"
	PlusInfinity     = "PLUS-INFINITY"
	Present          = "PRESENT"
	PrintableString  = "PrintableString"
	Private          = "PRIVATE"
	Real             = "REAL"
	RelativeOID      = "RELATIVE-OID"
	RelativeOIDIRI   = "RELATIVE-OID-IRI"
	Sequence         = "SEQUENCE"
	Set              = "SET"
	Settings         = "SETTINGS"
	Size             = "SIZE"
	String           = "STRING"
	Syntax           = "SYNTAX"
	T61String        = "T61String"
	Tags             = "TAGS"
	TeletexString    = "TeletexString"
	Time             = "TIME"
	TimeOfDay        = "TIME-OF-DAY"
	True             = "TRUE"
	TypeIdentifier   = "TYPE-IDENTIFIER"
	Union            = "UNION"
	Unique           = "UNIQUE"
	Universal        = "UNIVERSAL"
	UniversalString  = "UniversalString"
	UTCTime          = "UTCTime"
	UTF8String       = "UTF8String"
	VideotexString   = "VideotexString"
	VisibleString    = "VisibleString"
	With             = "WITH"
)

var Keywords = map[string]int{
	Absent:           ABSENT_SYMBOL,
	AbstractSyntax:   ABSTRACTSYNTAX_SYMBOL,
	All:              ALL_SYMBOL,
	Application:      APPLICATION_SYMBOL,
	Automatic:        AUTOMATIC_SYMBOL,
	Begin:            BEGIN_SYMBOL,
	Bit:              BIT_SYMBOL,
	BMPString:        BMPSTRING_SYMBOL,
	Boolean:          BOOLEAN_SYMBOL,
	By:               BY_SYMBOL,
	Character:        CHARACTER_SYMBOL,
	Choice:           CHOICE_SYMBOL,
	Class:            CLASS_SYMBOL,
	Component:        COMPONENT_SYMBOL,
	Components:       COMPONENTS_SYMBOL,
	Constrained:      CONSTRAINED_SYMBOL,
	Containing:       CONTAINING_SYMBOL,
	Date:             DATE_SYMBOL,
	DateTime:         DATETIME_SYMBOL,
	Default:          DEFAULT_SYMBOL,
	Definitions:      DEFINITIONS_SYMBOL,
	Duration:         DURATION_SYMBOL,
	Embedded:         EMBEDDED_SYMBOL,
	Encoded:          ENCODED_SYMBOL,
	EncodingControl:  ENCODINGCONTROL_SYMBOL,
	End:              END_SYMBOL,
	Enumerated:       ENUMERATED_SYMBOL,
	Except:           EXCEPT_SYMBOL,
	Explicit:         EXPLICIT_SYMBOL,
	Exports:          EXPORTS_SYMBOL,
	Extensibility:    EXTENSIBILITY_SYMBOL,
	Externel:         EXTERNEL_SYMBOL,
	False:            FALSE_SYMBOL,
	From:             FROM_SYMBOL,
	GeneralizedTime:  GENERALIZEDTIME_SYMBOL,
	GeneralString:    GENERALSTRING_SYMBOL,
	GraphicString:    GRAPHICSTRING_SYMBOL,
	IA5String:        IA5STRING_SYMBOL,
	Identifier:       IDENTIFIER_SYMBOL,
	Implicit:         IMPLICIT_SYMBOL,
	Implied:          IMPLIED_SYMBOL,
	Imports:          IMPORTS_SYMBOL,
	Includes:         INCLUDES_SYMBOL,
	Instance:         INSTANCE_SYMBOL,
	Instructions:     INSTRUCTIONS_SYMBOL,
	Integer:          INTEGER_SYMBOL,
	Intersection:     INTERSECTION_SYMBOL,
	ISO646String:     ISO646STRING_SYMBOL,
	Max:              MAX_SYMBOL,
	Min:              MIN_SYMBOL,
	MinusInfinity:    MINUSINFINITY_SYMBOL,
	NotANumber:       NOTANUMBER_SYMBOL,
	Null:             NULL_SYMBOL,
	NumericString:    NUMERICSTRING_SYMBOL,
	Object:           OBJECT_SYMBOL,
	ObjectDescriptor: OBJECTDESCRIPTOR_SYMBOL,
	Octet:            OCTET_SYMBOL,
	Of:               OF_SYMBOL,
	OIDIRI:           OIDIRI_SYMBOL,
	Optional:         OPTIONAL_SYMBOL,
	Pattern:          PATTERN_SYMBOL,
	PDV:              PDV_SYMBOL,
	PlusInfinity:     PLUSINFINITY_SYMBOL,
	Present:          PRESENT_SYMBOL,
	PrintableString:  PRINTABLESTRING_SYMBOL,
	Private:          PRIVATE_SYMBOL,
	Real:             REAL_SYMBOL,
	RelativeOID:      RELATIVEOID_SYMBOL,
	RelativeOIDIRI:   RELATIVEOIDIRI_SYMBOL,
	Sequence:         SEQUENCE_SYMBOL,
	Set:              SET_SYMBOL,
	Settings:         SETTINGS_SYMBOL,
	Size:             SIZE_SYMBOL,
	String:           STRING_SYMBOL,
	Syntax:           SYNTAX_SYMBOL,
	T61String:        T61STRING_SYMBOL,
	Tags:             TAGS_SYMBOL,
	TeletexString:    TELETEXSTRING_SYMBOL,
	Time:             TIME_SYMBOL,
	TimeOfDay:        TIMEOFDAY_SYMBOL,
	True:             TRUE_SYMBOL,
	TypeIdentifier:   TYPEIDENTIFIER_SYMBOL,
	Union:            UNION_SYMBOL,
	Unique:           UNIQUE_SYMBOL,
	Universal:        UNIVERSAL_SYMBOL,
	UniversalString:  UNIVERSALSTRING_SYMBOL,
	UTCTime:          UTCTIME_SYMBOL,
	UTF8String:       UTF8STRING_SYMBOL,
	VideotexString:   VIDEOTEXSTRING_SYMBOL,
	VisibleString:    VISIBLESTRING_SYMBOL,
	With:             WITH_SYMBOL,
}

var Tokens = map[int]string{
	ABSENT_SYMBOL:           Absent,
	ABSTRACTSYNTAX_SYMBOL:   AbstractSyntax,
	ALL_SYMBOL:              All,
	APPLICATION_SYMBOL:      Application,
	AUTOMATIC_SYMBOL:        Automatic,
	BEGIN_SYMBOL:            Begin,
	BIT_SYMBOL:              Bit,
	BMPSTRING_SYMBOL:        BMPString,
	BOOLEAN_SYMBOL:          Boolean,
	BY_SYMBOL:               By,
	CHARACTER_SYMBOL:        Character,
	CHOICE_SYMBOL:           Choice,
	CLASS_SYMBOL:            Class,
	COMPONENT_SYMBOL:        Component,
	COMPONENTS_SYMBOL:       Components,
	CONSTRAINED_SYMBOL:      Constrained,
	CONTAINING_SYMBOL:       Containing,
	DATE_SYMBOL:             Date,
	DATETIME_SYMBOL:         DateTime,
	DEFAULT_SYMBOL:          Default,
	DEFINITIONS_SYMBOL:      Definitions,
	DURATION_SYMBOL:         Duration,
	EMBEDDED_SYMBOL:         Embedded,
	ENCODED_SYMBOL:          Encoded,
	ENCODINGCONTROL_SYMBOL:  EncodingControl,
	END_SYMBOL:              End,
	ENUMERATED_SYMBOL:       Enumerated,
	EXCEPT_SYMBOL:           Except,
	EXPLICIT_SYMBOL:         Explicit,
	EXPORTS_SYMBOL:          Exports,
	EXTENSIBILITY_SYMBOL:    Extensibility,
	EXTERNEL_SYMBOL:         Externel,
	FALSE_SYMBOL:            False,
	FROM_SYMBOL:             From,
	GENERALIZEDTIME_SYMBOL:  GeneralizedTime,
	GENERALSTRING_SYMBOL:    GeneralString,
	GRAPHICSTRING_SYMBOL:    GraphicString,
	IA5STRING_SYMBOL:        IA5String,
	IDENTIFIER_SYMBOL:       Identifier,
	IMPLICIT_SYMBOL:         Implicit,
	IMPLIED_SYMBOL:          Implied,
	IMPORTS_SYMBOL:          Imports,
	INCLUDES_SYMBOL:         Includes,
	INSTANCE_SYMBOL:         Instance,
	INSTRUCTIONS_SYMBOL:     Instructions,
	INTEGER_SYMBOL:          Integer,
	INTERSECTION_SYMBOL:     Intersection,
	ISO646STRING_SYMBOL:     ISO646String,
	MAX_SYMBOL:              Max,
	MIN_SYMBOL:              Min,
	MINUSINFINITY_SYMBOL:    MinusInfinity,
	NOTANUMBER_SYMBOL:       NotANumber,
	NULL_SYMBOL:             Null,
	NUMERICSTRING_SYMBOL:    NumericString,
	OBJECT_SYMBOL:           Object,
	OBJECTDESCRIPTOR_SYMBOL: ObjectDescriptor,
	OCTET_SYMBOL:            Octet,
	OF_SYMBOL:               Of,
	OIDIRI_SYMBOL:           OIDIRI,
	OPTIONAL_SYMBOL:         Optional,
	PATTERN_SYMBOL:          Pattern,
	PDV_SYMBOL:              PDV,
	PLUSINFINITY_SYMBOL:     PlusInfinity,
	PRESENT_SYMBOL:          Present,
	PRINTABLESTRING_SYMBOL:  PrintableString,
	PRIVATE_SYMBOL:          Private,
	REAL_SYMBOL:             Real,
	RELATIVEOID_SYMBOL:      RelativeOID,
	RELATIVEOIDIRI_SYMBOL:   RelativeOIDIRI,
	SEQUENCE_SYMBOL:         Sequence,
	SET_SYMBOL:              Set,
	SETTINGS_SYMBOL:         Settings,
	SIZE_SYMBOL:             Size,
	STRING_SYMBOL:           String,
	SYNTAX_SYMBOL:           Syntax,
	T61STRING_SYMBOL:        T61String,
	TAGS_SYMBOL:             Tags,
	TELETEXSTRING_SYMBOL:    TeletexString,
	TIME_SYMBOL:             Time,
	TIMEOFDAY_SYMBOL:        TimeOfDay,
	TRUE_SYMBOL:             True,
	TYPEIDENTIFIER_SYMBOL:   TypeIdentifier,
	UNION_SYMBOL:            Union,
	UNIQUE_SYMBOL:           Unique,
	UNIVERSAL_SYMBOL:        Universal,
	UNIVERSALSTRING_SYMBOL:  UniversalString,
	UTCTIME_SYMBOL:          UTCTime,
	UTF8STRING_SYMBOL:       UTF8String,
	VIDEOTEXSTRING_SYMBOL:   VideotexString,
	VISIBLESTRING_SYMBOL:    VisibleString,
	WITH_SYMBOL:             With,
}

type Parser struct {
	Input       *bufio.Reader
	ErrorMsg    error
	Result      string
	ExpectBlock bool
}

func IsUpper(str string) bool {
	for _, r := range str {
		if !unicode.IsUpper(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func IsLower(str string) bool {
	for _, r := range str {
		if !unicode.IsLower(r) && unicode.IsLetter(r) {
			return false
		}
	}
	return true
}

func (p *Parser) Lex(lval *ASNSymType) int {
	for {
		b, err := p.Input.ReadByte()
		if err != nil {
			return 0
		}
		if b == 0 {
			return 0
		}
		if unicode.IsSpace(rune(b)) {
			continue
		}
		if unicode.IsLetter(rune(b)) {
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseString()
			if nil != err {
				return 0
			}
			lval.TypeString = STRING(value)
			if token, ok := Keywords[value]; ok {
				return token
			}
			if IsUpper(value) {
				return TokenCapitalString
			}
			return TokenString
		}
		if unicode.IsDigit(rune(b)) {
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			number, err := p.ParseNumber()
			if nil != err {
				return 0
			}

			//lval.TypeNumber = NUMBER(number)
			//return TokenNumber

			if number == float64(int64(number)) {
				lval.TypeNumber = NUMBER(number)
				return TokenInteger
			}
			lval.TypeNumber = NUMBER(number)
			return TokenFloat
		}
		switch b {
		case '-':
			return MINUS
		case '{':
			return CURLY_START
		case '[':
			return SQUARE_START
		case '(':
			return ROUND_START
		case '}':
			return CURLY_END
		case ']':
			return SQUARE_END
		case ')':
			return ROUND_END
		case ',':
			return COMMA
		case ':':
			return COLON
		case '"':
			if value, err := p.CanBeCharString(); nil == err {
				lval.TypeString = STRING(value)
				return TokenCString
			}
			return DOUBLE_QUOTE
		case '>':
			return GREATER_THAN
		case '<':
			return LESS_THAN
		case '.':
			if err := p.CanBeELLIPSIS(); nil == err {
				return ELLIPSIS
			}
			return DOT
		case '=':
			return EQUALITY
		case '/':
			return SLASH
		case '\'':
			if value, err := p.CanBeBinaryString(); nil == err {
				lval.TypeString = STRING(value)
				return TokenBString
			}
			if value, err := p.CanBeHexString(); nil == err {
				lval.TypeString = STRING(value)
				return TokenHString
			}
			return APOSTROPHE
		case ' ':
			return SPACE
		case '|':
			return PIPE
		case '@':
			return AT_THE_RATE
		case '^':
			return CARET
		case '!':
			return EXCLAMATION
		case ';':
			return SEMI_COMMA
		}
		break
	}
	return 0
}

func (p *Parser) CanBeELLIPSIS() error {
	var (
		count = 0
	)
	for count < 2 {
		b, err := p.Input.Peek(count + 1)
		if nil != err {
			return err
		}
		if !bytes.HasSuffix(b, []byte(".")) {
			return fmt.Errorf("invalid byte: %#U", rune(b[count]))
		}
		count++
	}
	_, _ = p.Input.Discard(count)
	return nil
}

func (p *Parser) CanBeCharString() (string, error) {
	var (
		buffer = strings.Builder{}
		count  = 0
	)
	for {
		b, err := p.Input.Peek(count + 1)
		if nil != err {
			return "", err
		}
		if bytes.HasSuffix(b, []byte("\"")) {
			count++
			b, err := p.Input.Peek(count + 1)
			if nil != err || !bytes.HasSuffix(b, []byte("\"\"")) {
				break
			}
		}
		count++
	}
	for i := 0; i < count-1; i++ {
		b, err := p.Input.Peek(i + 1)
		if nil != err {
			return "", err
		}
		buffer.WriteByte(b[i])
	}
	_, _ = p.Input.Discard(count)
	return strings.ReplaceAll(buffer.String(), "\"\"", "\""), nil
}

func (p *Parser) CanBeBinaryString() (string, error) {
	var (
		buffer = strings.Builder{}
		count  = 0
	)
	for {
		b, err := p.Input.Peek(count + 2)
		if nil != err {
			return "", err
		}
		if bytes.HasSuffix(b, []byte("'B")) {
			break
		}
		count++
	}
	for i := 0; i < count; i++ {
		b, err := p.Input.Peek(i + 1)
		if nil != err {
			return "", err
		}
		if b[i] != '0' && b[i] != '1' {
			return "", fmt.Errorf("encoding/binary: invalid byte: %#U", rune(b[count]))
		}
		buffer.WriteByte(b[i])
	}
	_, _ = p.Input.Discard(count + 2)
	return buffer.String(), nil
}

func (p *Parser) IsHexDigit(c byte) bool {
	switch {
	case '0' <= c && c <= '9':
		return true
	case 'a' <= c && c <= 'f':
		return true
	case 'A' <= c && c <= 'F':
		return true
	}
	return false
}

func (p *Parser) CanBeHexString() (string, error) {
	var (
		buffer = strings.Builder{}
		count  = 0
	)
	for {
		b, err := p.Input.Peek(count + 2)
		if nil != err {
			return "", err
		}
		if bytes.HasSuffix(b, []byte("'H")) {
			break
		}
		count++
	}
	for i := 0; i < count; i++ {
		b, err := p.Input.Peek(i + 1)
		if nil != err {
			return "", err
		}
		if !p.IsHexDigit(b[i]) {
			return "", fmt.Errorf("encoding/hex: invalid byte: %#U", rune(b[count]))
		}
		buffer.WriteByte(b[i])
	}
	_, _ = p.Input.Discard(count + 2)
	return buffer.String(), nil
}

func (p *Parser) ParseString() (string, error) {
	var (
		buffer = strings.Builder{}
	)
	for {
		b, err := p.Input.ReadByte()
		if err == io.EOF {
			break
		}
		if nil != err {
			return "", err
		}
		if !unicode.IsLetter(rune(b)) && !unicode.IsDigit(rune(b)) {
			if '-' != b {
				err := p.Input.UnreadByte()
				if nil != err {
					return "", err
				}
				break
			}
		}
		if unicode.IsSpace(rune(b)) {
			break
		}
		buffer.WriteByte(b)
	}
	return buffer.String(), nil
}

func (p *Parser) ParseNumber() (float64, error) {
	var (
		buffer = strings.Builder{}
	)
	for {
		b, err := p.Input.ReadByte()
		if err == io.EOF {
			break
		}
		if nil != err {
			return 0, err
		}
		if unicode.IsDigit(rune(b)) || b == '.' || b == 'e' || b == 'E' {
			buffer.WriteByte(b)
		} else {
			err := p.Input.UnreadByte()
			if nil != err {
				return 0, err
			}
			break
		}
	}
	return strconv.ParseFloat(buffer.String(), 64)
}

func (p *Parser) Error(msg string) {
	p.ErrorMsg = errors.New(msg)
}

func RemoveBlanks(buffer []byte) []byte {
	regex := regexp.MustCompile("(?m)^\\s*$[\r\n]*")
	return bytes.Trim(regex.ReplaceAll(buffer, []byte("")), "\r\n")
}

func RemoveBlockComment(content []byte) []byte {
	comment := regexp.MustCompile(`/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/`)
	return comment.ReplaceAll(content, []byte(""))
}

func RemoveLineComment(content []byte) []byte {
	comment := regexp.MustCompile(`--.*`)
	return comment.ReplaceAll(content, []byte(""))
}

func RemoveComments(content []byte) []byte {
	return RemoveBlanks(RemoveLineComment(RemoveBlockComment(content)))
}

var parser *Parser = nil

func MakeParser(content []byte) *Parser {
	parser = &Parser{
		Input: bufio.NewReader(bytes.NewReader(content)),
	}
	return parser
}

func Parse(content []byte) (string, error) {

	ASNDebug = 1
	ASNErrorVerbose = true

	content = RemoveComments(content)
	parser := MakeParser(content)
	ASNParse(parser)
	return parser.Result, parser.ErrorMsg
}
