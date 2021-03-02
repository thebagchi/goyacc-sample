package main

import (
	"fmt"
	"os"
)

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
}
