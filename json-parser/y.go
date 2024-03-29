// Code generated by goyacc -l -o y.go yacc.y. DO NOT EDIT.

package main

import __yyfmt__ "fmt"

func SetResult(l yyLexer, v interface{}) {
	l.(*Parser).Result = v
}

type yySymType struct {
	yys         int
	TypeToken   struct{}
	TypeString  string
	TypeNumber  float64
	TypeValue   interface{}
	TypeBoolean bool
	TypeNull    struct{}
	TypeObject  map[string]interface{}
	TypeList    []interface{}
}

const CURLY_START = 57346
const CURLY_END = 57347
const SQUARE_START = 57348
const SQUARE_END = 57349
const DOUBLE_QUOTE = 57350
const COMMA = 57351
const COLON = 57352
const MINUS = 57353
const TokenNumber = 57354
const TokenString = 57355
const TokenBoolean = 57356
const TokenNull = 57357
const TokenObject = 57358
const TokenList = 57359
const TokenValue = 57360

var yyToknames = [...]string{
	"$end",
	"error",
	"$unk",
	"CURLY_START",
	"CURLY_END",
	"SQUARE_START",
	"SQUARE_END",
	"DOUBLE_QUOTE",
	"COMMA",
	"COLON",
	"MINUS",
	"TokenNumber",
	"TokenString",
	"TokenBoolean",
	"TokenNull",
	"TokenObject",
	"TokenList",
	"TokenValue",
}

var yyStatenames = [...]string{}

const yyEofCode = 1
const yyErrCode = 2
const yyInitialStackSize = 16

var yyExca = [...]int{
	-1, 1,
	1, -1,
	-2, 0,
}

const yyPrivate = 57344

const yyLast = 37

var yyAct = [...]int{
	2, 26, 6, 20, 7, 17, 14, 29, 19, 12,
	11, 10, 9, 13, 16, 24, 23, 25, 21, 1,
	8, 18, 22, 15, 27, 6, 28, 7, 3, 5,
	30, 4, 12, 11, 10, 9, 13,
}

var yyPact = [...]int{
	21, -1000, -1000, -1000, -1000, -1000, 1, -2, -1000, -1000,
	-1000, -1000, -9, -1000, -1000, 13, 6, -1000, 8, -1000,
	-1000, -1000, -12, 21, -1000, 21, -3, -1000, -1000, 21,
	-1000,
}

var yyPgo = [...]int{
	0, 31, 29, 28, 23, 21, 0, 20, 19,
}

var yyR1 = [...]int{
	0, 8, 6, 6, 6, 6, 6, 6, 6, 6,
	1, 2, 2, 4, 4, 5, 5, 3, 7,
}

var yyR2 = [...]int{
	0, 1, 1, 1, 1, 2, 3, 2, 3, 1,
	1, 1, 2, 3, 5, 1, 3, 1, 1,
}

var yyChk = [...]int{
	-1000, -8, -6, -3, -1, -2, 4, 6, -7, 14,
	13, 12, 11, 15, 5, -4, 13, 7, -5, -6,
	12, 5, 9, 10, 7, 9, 13, -6, -6, 10,
	-6,
}

var yyDef = [...]int{
	0, -2, 1, 2, 3, 4, 0, 0, 9, 17,
	10, 11, 0, 18, 5, 0, 0, 7, 0, 15,
	12, 6, 0, 0, 8, 0, 0, 13, 16, 0,
	14,
}

var yyTok1 = [...]int{
	1,
}

var yyTok2 = [...]int{
	2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
	12, 13, 14, 15, 16, 17, 18,
}

var yyTok3 = [...]int{
	0,
}

var yyErrorMessages = [...]struct {
	state int
	token int
	msg   string
}{}

/*	parser for yacc output	*/

var (
	yyDebug        = 0
	yyErrorVerbose = false
)

type yyLexer interface {
	Lex(lval *yySymType) int
	Error(s string)
}

type yyParser interface {
	Parse(yyLexer) int
	Lookahead() int
}

type yyParserImpl struct {
	lval  yySymType
	stack [yyInitialStackSize]yySymType
	char  int
}

func (p *yyParserImpl) Lookahead() int {
	return p.char
}

func yyNewParser() yyParser {
	return &yyParserImpl{}
}

const yyFlag = -1000

func yyTokname(c int) string {
	if c >= 1 && c-1 < len(yyToknames) {
		if yyToknames[c-1] != "" {
			return yyToknames[c-1]
		}
	}
	return __yyfmt__.Sprintf("tok-%v", c)
}

func yyStatname(s int) string {
	if s >= 0 && s < len(yyStatenames) {
		if yyStatenames[s] != "" {
			return yyStatenames[s]
		}
	}
	return __yyfmt__.Sprintf("state-%v", s)
}

func yyErrorMessage(state, lookAhead int) string {
	const TOKSTART = 4

	if !yyErrorVerbose {
		return "syntax error"
	}

	for _, e := range yyErrorMessages {
		if e.state == state && e.token == lookAhead {
			return "syntax error: " + e.msg
		}
	}

	res := "syntax error: unexpected " + yyTokname(lookAhead)

	// To match Bison, suggest at most four expected tokens.
	expected := make([]int, 0, 4)

	// Look for shiftable tokens.
	base := yyPact[state]
	for tok := TOKSTART; tok-1 < len(yyToknames); tok++ {
		if n := base + tok; n >= 0 && n < yyLast && yyChk[yyAct[n]] == tok {
			if len(expected) == cap(expected) {
				return res
			}
			expected = append(expected, tok)
		}
	}

	if yyDef[state] == -2 {
		i := 0
		for yyExca[i] != -1 || yyExca[i+1] != state {
			i += 2
		}

		// Look for tokens that we accept or reduce.
		for i += 2; yyExca[i] >= 0; i += 2 {
			tok := yyExca[i]
			if tok < TOKSTART || yyExca[i+1] == 0 {
				continue
			}
			if len(expected) == cap(expected) {
				return res
			}
			expected = append(expected, tok)
		}

		// If the default action is to accept or reduce, give up.
		if yyExca[i+1] != 0 {
			return res
		}
	}

	for i, tok := range expected {
		if i == 0 {
			res += ", expecting "
		} else {
			res += " or "
		}
		res += yyTokname(tok)
	}
	return res
}

func yylex1(lex yyLexer, lval *yySymType) (char, token int) {
	token = 0
	char = lex.Lex(lval)
	if char <= 0 {
		token = yyTok1[0]
		goto out
	}
	if char < len(yyTok1) {
		token = yyTok1[char]
		goto out
	}
	if char >= yyPrivate {
		if char < yyPrivate+len(yyTok2) {
			token = yyTok2[char-yyPrivate]
			goto out
		}
	}
	for i := 0; i < len(yyTok3); i += 2 {
		token = yyTok3[i+0]
		if token == char {
			token = yyTok3[i+1]
			goto out
		}
	}

out:
	if token == 0 {
		token = yyTok2[1] /* unknown char */
	}
	if yyDebug >= 3 {
		__yyfmt__.Printf("lex %s(%d)\n", yyTokname(token), uint(char))
	}
	return char, token
}

func yyParse(yylex yyLexer) int {
	return yyNewParser().Parse(yylex)
}

func (yyrcvr *yyParserImpl) Parse(yylex yyLexer) int {
	var yyn int
	var yyVAL yySymType
	var yyDollar []yySymType
	_ = yyDollar // silence set and not used
	yyS := yyrcvr.stack[:]

	Nerrs := 0   /* number of errors */
	Errflag := 0 /* error recovery flag */
	yystate := 0
	yyrcvr.char = -1
	yytoken := -1 // yyrcvr.char translated into internal numbering
	defer func() {
		// Make sure we report no lookahead when not parsing.
		yystate = -1
		yyrcvr.char = -1
		yytoken = -1
	}()
	yyp := -1
	goto yystack

ret0:
	return 0

ret1:
	return 1

yystack:
	/* put a state and value onto the stack */
	if yyDebug >= 4 {
		__yyfmt__.Printf("char %v in %v\n", yyTokname(yytoken), yyStatname(yystate))
	}

	yyp++
	if yyp >= len(yyS) {
		nyys := make([]yySymType, len(yyS)*2)
		copy(nyys, yyS)
		yyS = nyys
	}
	yyS[yyp] = yyVAL
	yyS[yyp].yys = yystate

yynewstate:
	yyn = yyPact[yystate]
	if yyn <= yyFlag {
		goto yydefault /* simple state */
	}
	if yyrcvr.char < 0 {
		yyrcvr.char, yytoken = yylex1(yylex, &yyrcvr.lval)
	}
	yyn += yytoken
	if yyn < 0 || yyn >= yyLast {
		goto yydefault
	}
	yyn = yyAct[yyn]
	if yyChk[yyn] == yytoken { /* valid shift */
		yyrcvr.char = -1
		yytoken = -1
		yyVAL = yyrcvr.lval
		yystate = yyn
		if Errflag > 0 {
			Errflag--
		}
		goto yystack
	}

yydefault:
	/* default state action */
	yyn = yyDef[yystate]
	if yyn == -2 {
		if yyrcvr.char < 0 {
			yyrcvr.char, yytoken = yylex1(yylex, &yyrcvr.lval)
		}

		/* look through exception table */
		xi := 0
		for {
			if yyExca[xi+0] == -1 && yyExca[xi+1] == yystate {
				break
			}
			xi += 2
		}
		for xi += 2; ; xi += 2 {
			yyn = yyExca[xi+0]
			if yyn < 0 || yyn == yytoken {
				break
			}
		}
		yyn = yyExca[xi+1]
		if yyn < 0 {
			goto ret0
		}
	}
	if yyn == 0 {
		/* error ... attempt to resume parsing */
		switch Errflag {
		case 0: /* brand new error */
			yylex.Error(yyErrorMessage(yystate, yytoken))
			Nerrs++
			if yyDebug >= 1 {
				__yyfmt__.Printf("%s", yyStatname(yystate))
				__yyfmt__.Printf(" saw %s\n", yyTokname(yytoken))
			}
			fallthrough

		case 1, 2: /* incompletely recovered error ... try again */
			Errflag = 3

			/* find a state where "error" is a legal shift action */
			for yyp >= 0 {
				yyn = yyPact[yyS[yyp].yys] + yyErrCode
				if yyn >= 0 && yyn < yyLast {
					yystate = yyAct[yyn] /* simulate a shift of "error" */
					if yyChk[yystate] == yyErrCode {
						goto yystack
					}
				}

				/* the current p has no shift on "error", pop stack */
				if yyDebug >= 2 {
					__yyfmt__.Printf("error recovery pops state %d\n", yyS[yyp].yys)
				}
				yyp--
			}
			/* there is no state on the stack with an error shift ... abort */
			goto ret1

		case 3: /* no shift yet; clobber input char */
			if yyDebug >= 2 {
				__yyfmt__.Printf("error recovery discards %s\n", yyTokname(yytoken))
			}
			if yytoken == yyEofCode {
				goto ret1
			}
			yyrcvr.char = -1
			yytoken = -1
			goto yynewstate /* try again in the same state */
		}
	}

	/* reduction by production yyn */
	if yyDebug >= 2 {
		__yyfmt__.Printf("reduce %v in:\n\t%v\n", yyn, yyStatname(yystate))
	}

	yynt := yyn
	yypt := yyp
	_ = yypt // guard against "declared and not used"

	yyp -= yyR2[yyn]
	// yyp is now the index of $0. Perform the default action. Iff the
	// reduced production is ε, $1 is possibly out of range.
	if yyp+1 >= len(yyS) {
		nyys := make([]yySymType, len(yyS)*2)
		copy(nyys, yyS)
		yyS = nyys
	}
	yyVAL = yyS[yyp+1]

	/* consult goto table to find next state */
	yyn = yyR1[yyn]
	yyg := yyPgo[yyn]
	yyj := yyg + yyS[yyp].yys + 1

	if yyj >= yyLast {
		yystate = yyAct[yyg]
	} else {
		yystate = yyAct[yyj]
		if yyChk[yystate] != -yyn {
			yystate = yyAct[yyg]
		}
	}
	// dummy call; replaced with literal code
	switch yynt {

	case 1:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			SetResult(yylex, yyDollar[1].TypeValue)
		}
	case 2:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeValue = yyDollar[1].TypeBoolean
		}
	case 3:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeValue = yyDollar[1].TypeString
		}
	case 4:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeValue = yyDollar[1].TypeNumber
		}
	case 5:
		yyDollar = yyS[yypt-2 : yypt+1]
		{
			yyVAL.TypeValue = make(map[string]interface{})
		}
	case 6:
		yyDollar = yyS[yypt-3 : yypt+1]
		{
			yyVAL.TypeValue = yyDollar[2].TypeObject
		}
	case 7:
		yyDollar = yyS[yypt-2 : yypt+1]
		{
			yyVAL.TypeValue = make([]interface{}, 0)
		}
	case 8:
		yyDollar = yyS[yypt-3 : yypt+1]
		{
			yyVAL.TypeValue = yyDollar[2].TypeList
		}
	case 9:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeValue = nil
		}
	case 10:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeString = yyDollar[1].TypeString
		}
	case 11:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeNumber = yyDollar[1].TypeNumber
		}
	case 12:
		yyDollar = yyS[yypt-2 : yypt+1]
		{
			yyVAL.TypeNumber = (-1) * yyDollar[2].TypeNumber
		}
	case 13:
		yyDollar = yyS[yypt-3 : yypt+1]
		{
			yyVAL.TypeObject = map[string]interface{}{
				yyDollar[1].TypeString: yyDollar[3].TypeValue,
			}
		}
	case 14:
		yyDollar = yyS[yypt-5 : yypt+1]
		{
			yyVAL.TypeObject = yyDollar[1].TypeObject
			yyVAL.TypeObject[yyDollar[3].TypeString] = yyDollar[5].TypeValue
		}
	case 15:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeList = []interface{}{
				yyDollar[1].TypeValue,
			}
		}
	case 16:
		yyDollar = yyS[yypt-3 : yypt+1]
		{
			yyVAL.TypeList = yyDollar[1].TypeList
			yyVAL.TypeList = append(yyVAL.TypeList, yyDollar[3].TypeValue)
		}
	case 17:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeBoolean = yyDollar[1].TypeBoolean
		}
	case 18:
		yyDollar = yyS[yypt-1 : yypt+1]
		{
			yyVAL.TypeNull = yyDollar[1].TypeNull
		}
	}
	goto yystack /* stack new state and value */
}
