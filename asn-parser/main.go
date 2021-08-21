package main

import (
	"fmt"
	"os"
)

func main() {
	{
		content := `
MyModule1 {asn1(1) specification(0) modules(2) standard-modules(3)} DEFINITIONS ::=
BEGIN
END 

MyModule2 DEFINITIONS ::=
BEGIN
END

MyModule3 DEFINITIONS ::=
BEGIN
EXPORTS ALL;
END

MyModule4 DEFINITIONS ::=
BEGIN
EXPORTS exported;
END

MyModule5 DEFINITIONS ::=
BEGIN
EXPORTS exported-1,exported-2;
END

MyModule6 DEFINITIONS ::=
BEGIN
EXPORTS exported-1,exported-2;
IMPORTS;
END

MyModule7 DEFINITIONS ::=
BEGIN
IMPORTS;
EXPORTS exported-1,exported-2;
END

MyModule8 DEFINITIONS ::=
BEGIN
EXPORTS;
END

MyModule9 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName;
END

MyModule9 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName;
END

MyModule10 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName{iso(1)};
END

MyModule10 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName{iso};
END

MyModule11 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName{1};
END

MyModule11 DEFINITIONS ::=
BEGIN
IMPORTS imported FROM ModuleName{ieee(111) iso(1)};
END
`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		_ = result
	}
}
