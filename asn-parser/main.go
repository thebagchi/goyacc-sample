package main

import (
	"fmt"
	"os"
)

func main() {
	{
		content := `
MySyntax DEFINITIONS AUTOMATIC TAGS ::=
BEGIN
END 
`
		result, err := Parse([]byte(content))
		if nil != err {
			fmt.Println("Error: ", err)
			os.Exit(-1)
		}
		fmt.Println(result)
	}
}
