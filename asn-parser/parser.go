//go:generate goyacc -p ASN yacc.y
package main

import (
	"bytes"
	"errors"
)

type Parser struct {
	Input    *bytes.Buffer
	ErrorMsg error
	Result   ModuleDefinitions
}

func (p *Parser) Lex(lval *ASNSymType) int {
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
