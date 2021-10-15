//go:generate go run golang.org/x/tools/cmd/goyacc -l -o y.go yacc.y
package main

import (
	"bufio"
	"errors"
)

type Parser struct {
	Input    *bufio.Reader
	ErrorMsg error
	Result   interface{}
}

func (p *Parser) Lex(lval *yySymType) int {
	return 0
}

func (p *Parser) Error(msg string) {
	p.ErrorMsg = errors.New(msg)
}

func main() {

}
