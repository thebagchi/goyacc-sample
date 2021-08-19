package main

type TagDefault int

const (
	ExplicitTag TagDefault = iota
	ImplicitTag
	AutomaticTag
)

type DefinitiveIdentifier struct {
	Name string
	Id   int
}

type DefinitiveIdentifiers []DefinitiveIdentifier

type ModuleIdentifier struct {
	Reference             string
	DefinitiveIdentifiers DefinitiveIdentifiers
}

type ModuleExports struct {
	All     bool
	Symbols []string
}

type ModuleImports struct {
}

type Assignment struct {
}

type Assignments []Assignment

type ModuleBody struct {
	Exports     ModuleExports
	Imports     ModuleImports
	Assignments []Assignment
}

type ModuleDefinition struct {
	Identifier        ModuleIdentifier
	EncodingReference string
	Tag               TagDefault
	Extensibility     bool
	Body              ModuleBody
}

type ModuleDefinitions []ModuleDefinition
