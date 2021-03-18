package main

import (
	"encoding/json"
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
END
`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		data, err := json.MarshalIndent(result, "", "  ")
		if nil != err {
			fmt.Println("Error:", err)
		} else {
			fmt.Println(string(data))
		}
	}
}
