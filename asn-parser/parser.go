//go:generate goyacc -p ASN yacc.y
package main

import (
	"bytes"
	"errors"
	"unicode"
)

type Parser struct {
	Input    *bytes.Buffer
	ErrorMsg error
	Result   ModuleDefinitions
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
			return DOUBLE_QUOTE
		case '>':
			return GREATER_THAN
		case '<':
			return LESS_THAN
		case '.':
			return DOT
		case '=':
			return EQUALITY
		case '/':
			return SLASH
		case '\'':
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

func (p *Parser) Error(msg string) {
	p.ErrorMsg = errors.New(msg)
}

func Parse(content []byte) (ModuleDefinitions, error) {
	parser := &Parser{
		Input: bytes.NewBuffer(content),
	}
	ASNParse(parser)
	return parser.Result, parser.ErrorMsg
}
