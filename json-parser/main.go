//go:generate go run golang.org/x/tools/cmd/goyacc -l -o y.go yacc.y
package main

import (
	"bytes"
	"errors"
	"fmt"
	"os"
	"strings"
	"unicode"
)

type Parser struct {
	Input    *bytes.Buffer
	ErrorMsg error
	Result   interface{}
}

func (p *Parser) Lex(lval *yySymType) int {
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
		if unicode.IsDigit(rune(b)) {
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseNumber()
			if nil != err {
				return 0
			}
			lval.TypeNumber = value
			return TokenNumber
		}
		switch b {
		case '-':
			return MINUS
		case '{':
			return CURLY_START
		case '[':
			return SQUARE_START
		case '}':
			return CURLY_END
		case ']':
			return SQUARE_END
		case ',':
			return COMMA
		case ':':
			return COLON
		case '"':
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseString()
			if nil != err {
				return 0
			}
			lval.TypeString = value
			return TokenString
		case 't':
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseTrue()
			if nil != err {
				return 0
			}
			lval.TypeBoolean = value
			return TokenBoolean
		case 'f':
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseFalse()
			if nil != err {
				return 0
			}
			lval.TypeBoolean = value
			return TokenBoolean
		case 'n':
			err := p.Input.UnreadByte()
			if nil != err {
				return 0
			}
			value, err := p.ParseNull()
			if nil != err {
				return 0
			}
			lval.TypeNull = value
			return TokenNull
		}
		break
	}
	return 0
}

func (p *Parser) ParseNull() (struct{}, error) {
	return struct{}{}, nil
}

func (p *Parser) ParseFalse() (bool, error) {
	return false, nil
}

func (p *Parser) ParseTrue() (bool, error) {
	return true, nil
}

func (p *Parser) ParseNumber() (float64, error) {
	return 0, nil
}

func (p *Parser) ParseString() (string, error) {
	var (
		buffer = strings.Builder{}
	)
	for {
		b, err := p.Input.ReadByte()
		fmt.Println(string(b))
		if nil != err {
			return "", err
		}
		if b == '"' {
			break
		}
		buffer.WriteByte(b)
	}
	return buffer.String(), nil
}

func (p *Parser) Error(msg string) {
	p.ErrorMsg = errors.New(msg)
}

func Parse(content []byte) error {
	parser := &Parser{
		Input: bytes.NewBuffer(content),
	}
	yyParse(parser)
	return parser.ErrorMsg
}

func main() {
	content := `"Hello World"`
	err := Parse([]byte(content))
	if nil != err {
		fmt.Println("Error: ", err)
		os.Exit(-1)
	}
}
