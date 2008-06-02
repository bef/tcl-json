#!/usr/bin/env tclsh

package require ylex

set sg [yeti::ylex #auto -name jsonscanner]

##
## initialise scanner generator
##


$sg add {
	{"([^\\\"]|\\([\"\\/bfnrt]|u[0-9a-fA-F]{4}))*"} {
		return [list STRING [string range $yytext 1 [expr [string length $yytext]-2]]]
	}
	{\-?(0|[1-9]\d*)(\.\d+)?([eE][+-]?\d+)?} {
		return [list NUMBER $yytext]
	}
	{(true|false|null)} {
		return [list BOOL $yytext]
	}
	{\{} { return STARTBRACE }
	{\}} { return ENDBRACE }
	{\[} { return STARTBRACKET }
	{\]} { return ENDBRACKET }
	{,} { return COMMA }
	{:} { return COLON }
	{\s+} {
		## ignore whitespace
	}
}


##
## generate scanner
##

set scannertext [$sg dump]

set f [open "jsonscanner.tcl" w]
puts $f "## -- this code was generated automatically -- DO NOT EDIT !\n"
puts $f "package require Itcl 3.0"
puts $f "package provide jsonscanner 0.1"
puts $f "namespace eval ::json {"
puts $f $scannertext
puts $f "}"
close $f

