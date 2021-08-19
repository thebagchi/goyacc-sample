// Code generated by goyacc -p ASN asn.y. DO NOT EDIT.

//line asn.y:2
package main

import __yyfmt__ "fmt"

//line asn.y:2
func SetResult(l ASNLexer, v ModuleDefinitions) {
	l.(*Parser).Result = v
}

type Empty struct{}

//line asn.y:9
type ASNSymType struct {
	yys                       int
	TypeModuleDefinitions     ModuleDefinitions
	TypeModuleDefinition      ModuleDefinition
	TypeModuleIdentifer       ModuleIdentifier
	TypeDefinitiveIdentifiers DefinitiveIdentifiers
	TypeDefinitiveIdentifier  DefinitiveIdentifier
	TypeTagDefault            TagDefault
	TypeModuleBody            ModuleBody
	TypeModuleImports         ModuleImports
	TypeModuleExports         ModuleExports
	TypeAssignment            Assignment
	TypeAssignments           Assignments
	TypeToken                 Empty
	TypeString                string
	TypeInteger               int
	TypeFloat                 float64
	TypeBoolean               bool
	TypeListString            []string
}

const CURLY_START = 57346
const CURLY_END = 57347
const SQUARE_START = 57348
const SQUARE_END = 57349
const DOUBLE_QUOTE = 57350
const COMMA = 57351
const COLON = 57352
const MINUS = 57353
const GREATER_THAN = 57354
const LESS_THAN = 57355
const DOT = 57356
const SLASH = 57357
const ROUND_START = 57358
const ROUND_END = 57359
const EQUALITY = 57360
const APOSTROPHE = 57361
const SPACE = 57362
const PIPE = 57363
const AT_THE_RATE = 57364
const EXCLAMATION = 57365
const CARET = 57366
const SEMI_COMMA = 57367
const ABSENT_SYMBOL = 57368
const ABSTRACTSYNTAX_SYMBOL = 57369
const ALL_SYMBOL = 57370
const APPLICATION_SYMBOL = 57371
const AUTOMATIC_SYMBOL = 57372
const BEGIN_SYMBOL = 57373
const BIT_SYMBOL = 57374
const BMPSTRING_SYMBOL = 57375
const BOOLEAN_SYMBOL = 57376
const BY_SYMBOL = 57377
const CHARACTER_SYMBOL = 57378
const CHOICE_SYMBOL = 57379
const CLASS_SYMBOL = 57380
const COMPONENT_SYMBOL = 57381
const COMPONENTS_SYMBOL = 57382
const CONSTRAINED_SYMBOL = 57383
const CONTAINING_SYMBOL = 57384
const DATE_SYMBOL = 57385
const DATETIME_SYMBOL = 57386
const DEFAULT_SYMBOL = 57387
const DEFINITIONS_SYMBOL = 57388
const DURATION_SYMBOL = 57389
const EMBEDDED_SYMBOL = 57390
const ENCODED_SYMBOL = 57391
const ENCODINGCONTROL_SYMBOL = 57392
const END_SYMBOL = 57393
const ENUMERATED_SYMBOL = 57394
const EXCEPT_SYMBOL = 57395
const EXPLICIT_SYMBOL = 57396
const EXPORTS_SYMBOL = 57397
const EXTENSIBILITY_SYMBOL = 57398
const EXTERNEL_SYMBOL = 57399
const FALSE_SYMBOL = 57400
const FROM_SYMBOL = 57401
const GENERALIZEDTIME_SYMBOL = 57402
const GENERALSTRING_SYMBOL = 57403
const GRAPHICSTRING_SYMBOL = 57404
const IA5STRING_SYMBOL = 57405
const IDENTIFIER_SYMBOL = 57406
const IMPLICIT_SYMBOL = 57407
const IMPLIED_SYMBOL = 57408
const IMPORTS_SYMBOL = 57409
const INCLUDES_SYMBOL = 57410
const INSTANCE_SYMBOL = 57411
const INSTRUCTIONS_SYMBOL = 57412
const INTEGER_SYMBOL = 57413
const INTERSECTION_SYMBOL = 57414
const ISO646STRING_SYMBOL = 57415
const MAX_SYMBOL = 57416
const MIN_SYMBOL = 57417
const MINUSINFINITY_SYMBOL = 57418
const NOTANUMBER_SYMBOL = 57419
const NULL_SYMBOL = 57420
const NUMERICSTRING_SYMBOL = 57421
const OBJECT_SYMBOL = 57422
const OBJECTDESCRIPTOR_SYMBOL = 57423
const OCTET_SYMBOL = 57424
const OF_SYMBOL = 57425
const OIDIRI_SYMBOL = 57426
const OPTIONAL_SYMBOL = 57427
const PATTERN_SYMBOL = 57428
const PDV_SYMBOL = 57429
const PLUSINFINITY_SYMBOL = 57430
const PRESENT_SYMBOL = 57431
const PRINTABLESTRING_SYMBOL = 57432
const PRIVATE_SYMBOL = 57433
const REAL_SYMBOL = 57434
const RELATIVEOID_SYMBOL = 57435
const RELATIVEOIDIRI_SYMBOL = 57436
const SEQUENCE_SYMBOL = 57437
const SET_SYMBOL = 57438
const SETTINGS_SYMBOL = 57439
const SIZE_SYMBOL = 57440
const STRING_SYMBOL = 57441
const SYNTAX_SYMBOL = 57442
const T61STRING_SYMBOL = 57443
const TAGS_SYMBOL = 57444
const TELETEXSTRING_SYMBOL = 57445
const TIME_SYMBOL = 57446
const TIMEOFDAY_SYMBOL = 57447
const TRUE_SYMBOL = 57448
const TYPEIDENTIFIER_SYMBOL = 57449
const UNION_SYMBOL = 57450
const UNIQUE_SYMBOL = 57451
const UNIVERSAL_SYMBOL = 57452
const UNIVERSALSTRING_SYMBOL = 57453
const UTCTIME_SYMBOL = 57454
const UTF8STRING_SYMBOL = 57455
const VIDEOTEXSTRING_SYMBOL = 57456
const VISIBLESTRING_SYMBOL = 57457
const WITH_SYMBOL = 57458
const ASSIGNMENT_SYMBOL = 57459
const TokenCapitalString = 57460
const TokenString = 57461
const TokenInteger = 57462
const TokenFloat = 57463
const TokenBoolean = 57464

var ASNToknames = [...]string{
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
	"GREATER_THAN",
	"LESS_THAN",
	"DOT",
	"SLASH",
	"ROUND_START",
	"ROUND_END",
	"EQUALITY",
	"APOSTROPHE",
	"SPACE",
	"PIPE",
	"AT_THE_RATE",
	"EXCLAMATION",
	"CARET",
	"SEMI_COMMA",
	"ABSENT_SYMBOL",
	"ABSTRACTSYNTAX_SYMBOL",
	"ALL_SYMBOL",
	"APPLICATION_SYMBOL",
	"AUTOMATIC_SYMBOL",
	"BEGIN_SYMBOL",
	"BIT_SYMBOL",
	"BMPSTRING_SYMBOL",
	"BOOLEAN_SYMBOL",
	"BY_SYMBOL",
	"CHARACTER_SYMBOL",
	"CHOICE_SYMBOL",
	"CLASS_SYMBOL",
	"COMPONENT_SYMBOL",
	"COMPONENTS_SYMBOL",
	"CONSTRAINED_SYMBOL",
	"CONTAINING_SYMBOL",
	"DATE_SYMBOL",
	"DATETIME_SYMBOL",
	"DEFAULT_SYMBOL",
	"DEFINITIONS_SYMBOL",
	"DURATION_SYMBOL",
	"EMBEDDED_SYMBOL",
	"ENCODED_SYMBOL",
	"ENCODINGCONTROL_SYMBOL",
	"END_SYMBOL",
	"ENUMERATED_SYMBOL",
	"EXCEPT_SYMBOL",
	"EXPLICIT_SYMBOL",
	"EXPORTS_SYMBOL",
	"EXTENSIBILITY_SYMBOL",
	"EXTERNEL_SYMBOL",
	"FALSE_SYMBOL",
	"FROM_SYMBOL",
	"GENERALIZEDTIME_SYMBOL",
	"GENERALSTRING_SYMBOL",
	"GRAPHICSTRING_SYMBOL",
	"IA5STRING_SYMBOL",
	"IDENTIFIER_SYMBOL",
	"IMPLICIT_SYMBOL",
	"IMPLIED_SYMBOL",
	"IMPORTS_SYMBOL",
	"INCLUDES_SYMBOL",
	"INSTANCE_SYMBOL",
	"INSTRUCTIONS_SYMBOL",
	"INTEGER_SYMBOL",
	"INTERSECTION_SYMBOL",
	"ISO646STRING_SYMBOL",
	"MAX_SYMBOL",
	"MIN_SYMBOL",
	"MINUSINFINITY_SYMBOL",
	"NOTANUMBER_SYMBOL",
	"NULL_SYMBOL",
	"NUMERICSTRING_SYMBOL",
	"OBJECT_SYMBOL",
	"OBJECTDESCRIPTOR_SYMBOL",
	"OCTET_SYMBOL",
	"OF_SYMBOL",
	"OIDIRI_SYMBOL",
	"OPTIONAL_SYMBOL",
	"PATTERN_SYMBOL",
	"PDV_SYMBOL",
	"PLUSINFINITY_SYMBOL",
	"PRESENT_SYMBOL",
	"PRINTABLESTRING_SYMBOL",
	"PRIVATE_SYMBOL",
	"REAL_SYMBOL",
	"RELATIVEOID_SYMBOL",
	"RELATIVEOIDIRI_SYMBOL",
	"SEQUENCE_SYMBOL",
	"SET_SYMBOL",
	"SETTINGS_SYMBOL",
	"SIZE_SYMBOL",
	"STRING_SYMBOL",
	"SYNTAX_SYMBOL",
	"T61STRING_SYMBOL",
	"TAGS_SYMBOL",
	"TELETEXSTRING_SYMBOL",
	"TIME_SYMBOL",
	"TIMEOFDAY_SYMBOL",
	"TRUE_SYMBOL",
	"TYPEIDENTIFIER_SYMBOL",
	"UNION_SYMBOL",
	"UNIQUE_SYMBOL",
	"UNIVERSAL_SYMBOL",
	"UNIVERSALSTRING_SYMBOL",
	"UTCTIME_SYMBOL",
	"UTF8STRING_SYMBOL",
	"VIDEOTEXSTRING_SYMBOL",
	"VISIBLESTRING_SYMBOL",
	"WITH_SYMBOL",
	"ASSIGNMENT_SYMBOL",
	"TokenCapitalString",
	"TokenString",
	"TokenInteger",
	"TokenFloat",
	"TokenBoolean",
}

var ASNStatenames = [...]string{}

const ASNEofCode = 1
const ASNErrCode = 2
const ASNInitialStackSize = 16

//line asn.y:379

//line yacctab:1
var ASNExca = [...]int{
	-1, 1,
	1, -1,
	-2, 0,
	-1, 40,
	51, 29,
	-2, 31,
}

const ASNPrivate = 57344

const ASNLast = 116

var ASNAct = [...]int{
	27, 20, 21, 35, 6, 7, 51, 14, 34, 33,
	32, 26, 44, 25, 38, 31, 48, 36, 46, 9,
	50, 40, 52, 55, 45, 39, 29, 16, 37, 41,
	12, 3, 1, 5, 8, 42, 13, 24, 30, 22,
	47, 43, 49, 28, 19, 18, 17, 15, 23, 11,
	10, 4, 2, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 54,
	53, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 20, 21,
}

var ASNPact = [...]int{
	-114, -1000, -114, -1000, -27, 26, -1000, -1000, -1000, -111,
	-1000, -1000, -118, -17, -59, -5, -1000, -1000, -1000, -1000,
	10, -1000, -41, -92, -93, -94, -1000, -1000, -1000, -117,
	18, -52, -1000, -1000, -1000, 8, -10, 19, -1000, -1000,
	-55, 6, -33, -39, -1000, -1000, -1000, -113, -6, -113,
	-1000, 18, -2, -1000, -1000, -1000,
}

var ASNPgo = [...]int{
	0, 52, 31, 51, 50, 49, 47, 27, 46, 45,
	44, 42, 20, 41, 40, 17, 39, 38, 36, 35,
	33, 32,
}

var ASNR1 = [...]int{
	0, 21, 20, 20, 1, 1, 2, 15, 3, 4,
	4, 5, 6, 6, 7, 7, 7, 8, 9, 10,
	16, 16, 16, 16, 17, 17, 18, 18, 19, 19,
	13, 13, 14, 14, 14, 11, 11, 12,
}

var ASNR2 = [...]int{
	0, 1, 1, 1, 1, 2, 9, 3, 2, 1,
	0, 3, 1, 2, 1, 1, 1, 1, 1, 4,
	2, 2, 2, 0, 2, 0, 2, 0, 3, 0,
	1, 0, 1, 3, 0, 1, 2, 2,
}

var ASNChk = [...]int{
	-1000, -21, -1, -2, -3, -20, 118, 119, -2, 46,
	-4, -5, 4, -18, 118, -6, -7, -8, -9, -10,
	119, 120, -16, 65, 54, 30, 70, 5, -7, 16,
	-17, 56, 102, 102, 102, 120, -15, 10, 66, 17,
	31, 10, -19, -13, 67, 18, 51, -14, 55, -11,
	-12, 119, 28, -12, -15, 25,
}

var ASNDef = [...]int{
	0, -2, 1, 4, 0, 10, 2, 3, 5, 27,
	8, 9, 0, 23, 0, 0, 12, 14, 15, 16,
	17, 18, 25, 0, 0, 0, 26, 11, 13, 0,
	0, 0, 20, 21, 22, 0, 0, 0, 24, 19,
	-2, 0, 0, 34, 30, 7, 6, 0, 32, 28,
	35, 0, 0, 36, 37, 33,
}

var ASNTok1 = [...]int{
	1,
}

var ASNTok2 = [...]int{
	2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
	12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
	22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
	32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
	42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
	62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
	72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
	82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
	92, 93, 94, 95, 96, 97, 98, 99, 100, 101,
	102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
	112, 113, 114, 115, 116, 117, 118, 119, 120, 121,
	122,
}

var ASNTok3 = [...]int{
	0,
}

var ASNErrorMessages = [...]struct {
	state int
	token int
	msg   string
}{}

//line yaccpar:1

/*	parser for yacc output	*/

var (
	ASNDebug        = 0
	ASNErrorVerbose = false
)

type ASNLexer interface {
	Lex(lval *ASNSymType) int
	Error(s string)
}

type ASNParser interface {
	Parse(ASNLexer) int
	Lookahead() int
}

type ASNParserImpl struct {
	lval  ASNSymType
	stack [ASNInitialStackSize]ASNSymType
	char  int
}

func (p *ASNParserImpl) Lookahead() int {
	return p.char
}

func ASNNewParser() ASNParser {
	return &ASNParserImpl{}
}

const ASNFlag = -1000

func ASNTokname(c int) string {
	if c >= 1 && c-1 < len(ASNToknames) {
		if ASNToknames[c-1] != "" {
			return ASNToknames[c-1]
		}
	}
	return __yyfmt__.Sprintf("tok-%v", c)
}

func ASNStatname(s int) string {
	if s >= 0 && s < len(ASNStatenames) {
		if ASNStatenames[s] != "" {
			return ASNStatenames[s]
		}
	}
	return __yyfmt__.Sprintf("state-%v", s)
}

func ASNErrorMessage(state, lookAhead int) string {
	const TOKSTART = 4

	if !ASNErrorVerbose {
		return "syntax error"
	}

	for _, e := range ASNErrorMessages {
		if e.state == state && e.token == lookAhead {
			return "syntax error: " + e.msg
		}
	}

	res := "syntax error: unexpected " + ASNTokname(lookAhead)

	// To match Bison, suggest at most four expected tokens.
	expected := make([]int, 0, 4)

	// Look for shiftable tokens.
	base := ASNPact[state]
	for tok := TOKSTART; tok-1 < len(ASNToknames); tok++ {
		if n := base + tok; n >= 0 && n < ASNLast && ASNChk[ASNAct[n]] == tok {
			if len(expected) == cap(expected) {
				return res
			}
			expected = append(expected, tok)
		}
	}

	if ASNDef[state] == -2 {
		i := 0
		for ASNExca[i] != -1 || ASNExca[i+1] != state {
			i += 2
		}

		// Look for tokens that we accept or reduce.
		for i += 2; ASNExca[i] >= 0; i += 2 {
			tok := ASNExca[i]
			if tok < TOKSTART || ASNExca[i+1] == 0 {
				continue
			}
			if len(expected) == cap(expected) {
				return res
			}
			expected = append(expected, tok)
		}

		// If the default action is to accept or reduce, give up.
		if ASNExca[i+1] != 0 {
			return res
		}
	}

	for i, tok := range expected {
		if i == 0 {
			res += ", expecting "
		} else {
			res += " or "
		}
		res += ASNTokname(tok)
	}
	return res
}

func ASNlex1(lex ASNLexer, lval *ASNSymType) (char, token int) {
	token = 0
	char = lex.Lex(lval)
	if char <= 0 {
		token = ASNTok1[0]
		goto out
	}
	if char < len(ASNTok1) {
		token = ASNTok1[char]
		goto out
	}
	if char >= ASNPrivate {
		if char < ASNPrivate+len(ASNTok2) {
			token = ASNTok2[char-ASNPrivate]
			goto out
		}
	}
	for i := 0; i < len(ASNTok3); i += 2 {
		token = ASNTok3[i+0]
		if token == char {
			token = ASNTok3[i+1]
			goto out
		}
	}

out:
	if token == 0 {
		token = ASNTok2[1] /* unknown char */
	}
	if ASNDebug >= 3 {
		__yyfmt__.Printf("lex %s(%d)\n", ASNTokname(token), uint(char))
	}
	return char, token
}

func ASNParse(ASNlex ASNLexer) int {
	return ASNNewParser().Parse(ASNlex)
}

func (ASNrcvr *ASNParserImpl) Parse(ASNlex ASNLexer) int {
	var ASNn int
	var ASNVAL ASNSymType
	var ASNDollar []ASNSymType
	_ = ASNDollar // silence set and not used
	ASNS := ASNrcvr.stack[:]

	Nerrs := 0   /* number of errors */
	Errflag := 0 /* error recovery flag */
	ASNstate := 0
	ASNrcvr.char = -1
	ASNtoken := -1 // ASNrcvr.char translated into internal numbering
	defer func() {
		// Make sure we report no lookahead when not parsing.
		ASNstate = -1
		ASNrcvr.char = -1
		ASNtoken = -1
	}()
	ASNp := -1
	goto ASNstack

ret0:
	return 0

ret1:
	return 1

ASNstack:
	/* put a state and value onto the stack */
	if ASNDebug >= 4 {
		__yyfmt__.Printf("char %v in %v\n", ASNTokname(ASNtoken), ASNStatname(ASNstate))
	}

	ASNp++
	if ASNp >= len(ASNS) {
		nyys := make([]ASNSymType, len(ASNS)*2)
		copy(nyys, ASNS)
		ASNS = nyys
	}
	ASNS[ASNp] = ASNVAL
	ASNS[ASNp].yys = ASNstate

ASNnewstate:
	ASNn = ASNPact[ASNstate]
	if ASNn <= ASNFlag {
		goto ASNdefault /* simple state */
	}
	if ASNrcvr.char < 0 {
		ASNrcvr.char, ASNtoken = ASNlex1(ASNlex, &ASNrcvr.lval)
	}
	ASNn += ASNtoken
	if ASNn < 0 || ASNn >= ASNLast {
		goto ASNdefault
	}
	ASNn = ASNAct[ASNn]
	if ASNChk[ASNn] == ASNtoken { /* valid shift */
		ASNrcvr.char = -1
		ASNtoken = -1
		ASNVAL = ASNrcvr.lval
		ASNstate = ASNn
		if Errflag > 0 {
			Errflag--
		}
		goto ASNstack
	}

ASNdefault:
	/* default state action */
	ASNn = ASNDef[ASNstate]
	if ASNn == -2 {
		if ASNrcvr.char < 0 {
			ASNrcvr.char, ASNtoken = ASNlex1(ASNlex, &ASNrcvr.lval)
		}

		/* look through exception table */
		xi := 0
		for {
			if ASNExca[xi+0] == -1 && ASNExca[xi+1] == ASNstate {
				break
			}
			xi += 2
		}
		for xi += 2; ; xi += 2 {
			ASNn = ASNExca[xi+0]
			if ASNn < 0 || ASNn == ASNtoken {
				break
			}
		}
		ASNn = ASNExca[xi+1]
		if ASNn < 0 {
			goto ret0
		}
	}
	if ASNn == 0 {
		/* error ... attempt to resume parsing */
		switch Errflag {
		case 0: /* brand new error */
			ASNlex.Error(ASNErrorMessage(ASNstate, ASNtoken))
			Nerrs++
			if ASNDebug >= 1 {
				__yyfmt__.Printf("%s", ASNStatname(ASNstate))
				__yyfmt__.Printf(" saw %s\n", ASNTokname(ASNtoken))
			}
			fallthrough

		case 1, 2: /* incompletely recovered error ... try again */
			Errflag = 3

			/* find a state where "error" is a legal shift action */
			for ASNp >= 0 {
				ASNn = ASNPact[ASNS[ASNp].yys] + ASNErrCode
				if ASNn >= 0 && ASNn < ASNLast {
					ASNstate = ASNAct[ASNn] /* simulate a shift of "error" */
					if ASNChk[ASNstate] == ASNErrCode {
						goto ASNstack
					}
				}

				/* the current p has no shift on "error", pop stack */
				if ASNDebug >= 2 {
					__yyfmt__.Printf("error recovery pops state %d\n", ASNS[ASNp].yys)
				}
				ASNp--
			}
			/* there is no state on the stack with an error shift ... abort */
			goto ret1

		case 3: /* no shift yet; clobber input char */
			if ASNDebug >= 2 {
				__yyfmt__.Printf("error recovery discards %s\n", ASNTokname(ASNtoken))
			}
			if ASNtoken == ASNEofCode {
				goto ret1
			}
			ASNrcvr.char = -1
			ASNtoken = -1
			goto ASNnewstate /* try again in the same state */
		}
	}

	/* reduction by production ASNn */
	if ASNDebug >= 2 {
		__yyfmt__.Printf("reduce %v in:\n\t%v\n", ASNn, ASNStatname(ASNstate))
	}

	ASNnt := ASNn
	ASNpt := ASNp
	_ = ASNpt // guard against "declared and not used"

	ASNp -= ASNR2[ASNn]
	// ASNp is now the index of $0. Perform the default action. Iff the
	// reduced production is ε, $1 is possibly out of range.
	if ASNp+1 >= len(ASNS) {
		nyys := make([]ASNSymType, len(ASNS)*2)
		copy(nyys, ASNS)
		ASNS = nyys
	}
	ASNVAL = ASNS[ASNp+1]

	/* consult goto table to find next state */
	ASNn = ASNR1[ASNn]
	ASNg := ASNPgo[ASNn]
	ASNj := ASNg + ASNS[ASNp].yys + 1

	if ASNj >= ASNLast {
		ASNstate = ASNAct[ASNg]
	} else {
		ASNstate = ASNAct[ASNj]
		if ASNChk[ASNstate] != -ASNn {
			ASNstate = ASNAct[ASNg]
		}
	}
	// dummy call; replaced with literal code
	switch ASNnt {

	case 1:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:178
		{
			SetResult(ASNlex, ASNDollar[1].TypeModuleDefinitions)
		}
	case 2:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:183
		{
			ASNVAL.TypeString = ASNDollar[1].TypeString
		}
	case 3:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:186
		{
			ASNVAL.TypeString = ASNDollar[1].TypeString
		}
	case 4:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:191
		{
			ASNVAL.TypeModuleDefinitions = []ModuleDefinition{
				ASNDollar[1].TypeModuleDefinition,
			}
		}
	case 5:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:196
		{
			ASNVAL.TypeModuleDefinitions = ASNDollar[1].TypeModuleDefinitions
			ASNVAL.TypeModuleDefinitions = append(ASNVAL.TypeModuleDefinitions, ASNDollar[2].TypeModuleDefinition)
		}
	case 6:
		ASNDollar = ASNS[ASNpt-9 : ASNpt+1]
//line asn.y:211
		{
			ASNVAL.TypeModuleDefinition = ModuleDefinition{
				Identifier: ASNDollar[1].TypeModuleIdentifer,
			}
		}
	case 7:
		ASNDollar = ASNS[ASNpt-3 : ASNpt+1]
//line asn.y:218
		{
			ASNVAL.TypeString = "::="
		}
	case 8:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:225
		{
			ASNVAL.TypeModuleIdentifer = ModuleIdentifier{
				Reference:             ASNDollar[1].TypeString,
				DefinitiveIdentifiers: ASNDollar[2].TypeDefinitiveIdentifiers,
			}
		}
	case 9:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:233
		{
			ASNVAL.TypeDefinitiveIdentifiers = ASNDollar[1].TypeDefinitiveIdentifiers
		}
	case 10:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:236
		{
			ASNVAL.TypeDefinitiveIdentifiers = make(DefinitiveIdentifiers, 0)
		}
	case 11:
		ASNDollar = ASNS[ASNpt-3 : ASNpt+1]
//line asn.y:241
		{
			ASNVAL.TypeDefinitiveIdentifiers = ASNDollar[2].TypeDefinitiveIdentifiers
		}
	case 12:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:246
		{
			ASNVAL.TypeDefinitiveIdentifiers = []DefinitiveIdentifier{
				ASNDollar[1].TypeDefinitiveIdentifier,
			}
		}
	case 13:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:251
		{
			ASNVAL.TypeDefinitiveIdentifiers = ASNDollar[1].TypeDefinitiveIdentifiers
			ASNVAL.TypeDefinitiveIdentifiers = append(ASNVAL.TypeDefinitiveIdentifiers, ASNDollar[2].TypeDefinitiveIdentifier)
		}
	case 14:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:257
		{
			ASNVAL.TypeDefinitiveIdentifier = ASNDollar[1].TypeDefinitiveIdentifier
		}
	case 15:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:260
		{
			ASNVAL.TypeDefinitiveIdentifier = ASNDollar[1].TypeDefinitiveIdentifier
		}
	case 16:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:263
		{
			ASNVAL.TypeDefinitiveIdentifier = ASNDollar[1].TypeDefinitiveIdentifier
		}
	case 17:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:268
		{
			ASNVAL.TypeDefinitiveIdentifier = DefinitiveIdentifier{
				Name: ASNDollar[1].TypeString,
			}
		}
	case 18:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:275
		{
			ASNVAL.TypeDefinitiveIdentifier = DefinitiveIdentifier{
				Id: ASNDollar[1].TypeInteger,
			}
		}
	case 19:
		ASNDollar = ASNS[ASNpt-4 : ASNpt+1]
//line asn.y:282
		{
			ASNVAL.TypeDefinitiveIdentifier = DefinitiveIdentifier{
				Name: ASNDollar[1].TypeString,
				Id:   ASNDollar[3].TypeInteger,
			}
		}
	case 20:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:290
		{
			ASNVAL.TypeTagDefault = ImplicitTag
		}
	case 21:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:293
		{
			ASNVAL.TypeTagDefault = ExplicitTag
		}
	case 22:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:296
		{
			ASNVAL.TypeTagDefault = AutomaticTag
		}
	case 23:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:299
		{
			ASNVAL.TypeTagDefault = ExplicitTag
		}
	case 24:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:304
		{
			ASNVAL.TypeBoolean = true
		}
	case 25:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:307
		{
			ASNVAL.TypeBoolean = false
		}
	case 26:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:312
		{
			ASNVAL.TypeString = ASNDollar[1].TypeString
		}
	case 27:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:315
		{
			ASNVAL.TypeString = ""
		}
	case 28:
		ASNDollar = ASNS[ASNpt-3 : ASNpt+1]
//line asn.y:322
		{
			ASNVAL.TypeModuleBody = ModuleBody{
				Imports: ASNDollar[1].TypeModuleImports,
				Exports: ASNDollar[2].TypeModuleExports,
			}
		}
	case 29:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:328
		{
			ASNVAL.TypeModuleBody = ModuleBody{
				// Empty
			}
		}
	case 30:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:335
		{
			ASNVAL.TypeModuleImports = ModuleImports{
				// Empty
			}
		}
	case 31:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:340
		{
			ASNVAL.TypeModuleImports = ModuleImports{
				// EMPTY
			}
		}
	case 32:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:347
		{
			ASNVAL.TypeModuleExports = ModuleExports{
				// Empty
			}
		}
	case 33:
		ASNDollar = ASNS[ASNpt-3 : ASNpt+1]
//line asn.y:352
		{
			ASNVAL.TypeModuleExports = ModuleExports{
				All: true,
			}
		}
	case 34:
		ASNDollar = ASNS[ASNpt-0 : ASNpt+1]
//line asn.y:357
		{
			ASNVAL.TypeModuleExports = ModuleExports{
				// Empty
			}
		}
	case 35:
		ASNDollar = ASNS[ASNpt-1 : ASNpt+1]
//line asn.y:364
		{
			ASNVAL.TypeAssignments = []Assignment{
				ASNDollar[1].TypeAssignment,
			}
		}
	case 36:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:369
		{
			ASNVAL.TypeAssignments = ASNDollar[1].TypeAssignments
			ASNVAL.TypeAssignments = append(ASNVAL.TypeAssignments, ASNDollar[2].TypeAssignment)
		}
	case 37:
		ASNDollar = ASNS[ASNpt-2 : ASNpt+1]
//line asn.y:376
		{

		}
	}
	goto ASNstack /* stack new state and value */
}
