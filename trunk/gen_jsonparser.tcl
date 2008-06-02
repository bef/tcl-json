#!/usr/bin/env tclsh

package require ylex
package require yeti

set pg [yeti::yeti #auto -name jsonparser]

##
## initialise paresr generator
##

$pg add {
	start {nt_object} { return $1 }
	
	nt_object {STARTBRACE nt_oitems ENDBRACE} {
		return [list object $2]
	}
	
	nt_oitems {nt_oitems COMMA nt_oitem} { return [concat $1 $3] }
	nt_oitems {nt_oitem} { return $1 }
	nt_oitems {} { return {} }
	
	nt_oitem {STRING COLON nt_value} { return [list $1 $3] }
	
	nt_value {STRING} { return [list string $1] }
	nt_value {NUMBER} { return [list number $1] }
	nt_value {nt_array} { return $1 }
	nt_value {nt_object} { return $1 }
	nt_value {BOOL} { return [list bool $1] }
	
	nt_array {STARTBRACKET nt_aitems ENDBRACKET} { return [list array $2] }
	nt_aitems {nt_aitems COMMA nt_value} {}
	nt_aitems {nt_value} {}
	nt_aitems {} {}
}


##
## generate parser
##

set parsertext [$pg dump]

set f [open "jsonparser.tcl" w]
puts $f "## -- this code was generated automatically -- DO NOT EDIT !\n"
puts $f "package require Itcl 3.0"
puts $f "package provide jsonparser 0.1"
puts $f "namespace eval ::json {"
puts $f $parsertext
puts $f "}"
close $f

