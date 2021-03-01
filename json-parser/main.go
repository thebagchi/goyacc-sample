//go:generate go run golang.org/x/tools/cmd/goyacc -l -o y.go yacc.y
package main

import (
	"bytes"
	"errors"
	"fmt"
	"io"
	"os"
	"strconv"
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
	var (
		buffer = strings.Builder{}
		empty  struct{}
	)
	for i := 0; i < 4; i++ {
		b, err := p.Input.ReadByte()
		if nil != err {
			return empty, err
		}
		buffer.WriteByte(b)
	}
	if 0 != strings.Compare(buffer.String(), "null") {
		return empty, errors.New("failed parsing null")
	}
	return empty, nil
}

func (p *Parser) ParseFalse() (bool, error) {
	var (
		buffer = strings.Builder{}
	)
	for i := 0; i < 5; i++ {
		b, err := p.Input.ReadByte()
		if nil != err {
			return false, err
		}
		buffer.WriteByte(b)
	}
	if 0 != strings.Compare(buffer.String(), "false") {
		return false, errors.New("failed parsing false")
	}
	return false, nil
}

func (p *Parser) ParseTrue() (bool, error) {
	var (
		buffer = strings.Builder{}
	)
	for i := 0; i < 4; i++ {
		b, err := p.Input.ReadByte()
		if nil != err {
			return false, err
		}
		buffer.WriteByte(b)
	}
	if 0 != strings.Compare(buffer.String(), "true") {
		return false, errors.New("failed parsing true")
	}
	return true, nil
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
		if unicode.IsDigit(rune(b)) || b == '.' {
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

func (p *Parser) ParseString() (string, error) {
	var (
		buffer = strings.Builder{}
		count  = 0
	)
	for {
		b, err := p.Input.ReadByte()
		if nil != err {
			return "", err
		}
		if b == '"' {
			if count == 0 {
				count += 1
				continue
			}
			break
		}
		if b == '\\' {
			b, err := p.Input.ReadByte()
			if nil != err {
				return "", nil
			}
			buffer.WriteByte(b)
			continue
		}
		buffer.WriteByte(b)
	}
	return buffer.String(), nil
}

func (p *Parser) Error(msg string) {
	p.ErrorMsg = errors.New(msg)
}

func Parse(content []byte) (interface{}, error) {
	parser := &Parser{
		Input: bytes.NewBuffer(content),
	}
	yyParse(parser)
	return parser.Result, parser.ErrorMsg
}

func main() {
	{
		content := `"Hello World"`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `true`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `false`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `null`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `12345`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `[12345,54321]`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `["Hello","World"]`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `{"Hello":"World"}`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `[]`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `{}`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
	{
		content := `""`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
}
