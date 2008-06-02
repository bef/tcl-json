## -- this code was generated automatically -- DO NOT EDIT !

package require Itcl 3.0
package provide jsonscanner 0.1
namespace eval ::json {
itcl::class jsonscanner {
    public variable case 1
    public variable verbose 0
    public variable verbout stderr
    private variable yyistcl83 -1

    public variable yydata ""
    public variable yyindex 0
    private variable yymatches

    public variable yystate "INITIAL"
    public variable yytext
    public variable yystart
    public variable yyend

    private common yyregexs
    private common yyigncase
    private common yystates

    array set yyregexs {
        1 {"([^\\\"]|\\([\"\\/bfnrt]|u[0-9a-fA-F]{4}))*"}
        2 {\-?(0|[1-9]\d*)(\.\d+)?([eE][+-]?\d+)?}
        3 {(true|false|null)}
        4 {\{}
        5 {\}}
        6 {\[}
        7 {\]}
        8 {,}
        9 {:}
        10 {\s+}
    }

    array set yyigncase {
        1 0
        2 0
        3 0
        4 0
        5 0
        6 0
        7 0
        8 0
        9 0
        10 0
    }

    array set yystates {
        __all__ {
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
        }
    }

    constructor {args} {
        eval $this configure $args
    }
    
    public method reset {} {
        if {$verbose} {
            puts $verbout "jsonscanner: reset, entering state INITIAL"
        }
        
        set yyindex 0
        set yystate "INITIAL"
        catch {unset yymatches}
    }
    
    public method start {yynewstr} {
        reset
        set yydata $yynewstr
    }
    
    protected method yyerror {yyerrmsg} {
        puts $verbout "jsonscanner: $yyerrmsg"
    }
    
    private method yyupdate {} {
        if {$yyistcl83 == -1} {
            if {[package vcompare [info tclversion] 8.3] >= 0} {
                set yyistcl83 1
            } else {
                set yyistcl83 0
            }
        }
        
        set yybestmatch -1
        set yybestbegin [string length $yydata]
        set yybestend   $yybestbegin
        
        if {$verbose >= 2} {
            set yycurdata [string range $yydata $yyindex [expr {$yyindex + 16}]]
            set yycurout [string map {\r \\r \n \\n} $yycurdata]
            if {$yyindex + 16 < [string length $yydata]} {
                append yycurout "..."
            }
            puts $verbout "jsonscanner: looking for match at position $yyindex: `$yycurout'"
        }
        
        if {[info exists yystates($yystate)]} {
            set yyruleset [concat $yystates($yystate) $yystates(__all__)]
        } else {
            set yyruleset $yystates(__all__)
        }
        
        if {[llength $yyruleset] == 0} {
            if {$verbose} {
                puts $verbout "jsonscanner: no active rules in state $yystate"
            }
        }


        foreach yyruleno $yyruleset {
            #
            # if the last match is in the past, rerun regexp
            #

            if {![info exists yymatches($yyruleno)] ||  [lindex [lindex $yymatches($yyruleno) 0] 0] < $yyindex} {
                if {$yyistcl83} {
                    if {!$case || $yyigncase($yyruleno)} {
                        set yyfound [regexp -nocase -start $yyindex  -inline -indices --  $yyregexs($yyruleno) $yydata]
                    } else {
                        set yyfound [regexp -start $yyindex  -inline -indices --  $yyregexs($yyruleno) $yydata]
                    }
                } else {
                    if {!$case || $yyigncase($yyruleno)} {
                        set yyres [regexp -nocase -start $yyindex  -indices -- $yyregexs($yyruleno)  $yydata yyfound]
                    } else {
                        set yyres [regexp -start $yyindex  -indices -- $yyregexs($yyruleno)  $yydata yyfound]
                    }
                    
                    if {!$yyres} {
                        set yyfound [list]
                    } else {
                        set yyfound [list $yyfound]
                    }
                }

                if {[llength $yyfound] > 0} {
                    set yymatches($yyruleno) $yyfound
                } else {
                    set yymatches($yyruleno) [list  [string length $yydata]  [string length $yydata]]
                }

                if {$verbose >= 3 && [llength $yymatches($yyruleno)] > 0} {
                    set yymatchbegin [lindex [lindex $yymatches($yyruleno) 0] 0]
                    set yymatchend [lindex [lindex $yymatches($yyruleno) 0] 1]
                    if {$yymatchbegin != [string length $yydata]} {
                        set yymatchdata [string range $yydata $yymatchbegin $yymatchend]
			set yymatchout [string map {\r "\\r" \n "\\n"} $yymatchdata]
			if {[string length $yymatchout] > 20} {
			    set yymatchout [string range $yymatchout 0 16]
			    append yymatchout "..."
			}
                        puts $verbout "jsonscanner: next match for rule $yyruleno is $yymatchbegin-$yymatchend: `$yymatchout'"
                    } else {
                        puts $verbout "jsonscanner: rule $yyruleno does not match anwhere in remaining text"
		    }
                }
            }

            #
            # see if the match is better than the one we already have
            #

            set yymatchbegin [lindex [lindex $yymatches($yyruleno) 0] 0]
            set yymatchend [lindex [lindex $yymatches($yyruleno) 0] 1]

            if {($yymatchbegin < $yybestbegin) ||  ($yymatchbegin == $yybestbegin && $yymatchend > $yybestend)} {
                set yybestmatch $yyruleno
                set yybestbegin $yymatchbegin
                set yybestend   $yymatchend

                if {$verbose >= 2} {
                    set yybestdata [string range $yydata $yybestbegin $yybestend]
		    set yymatchout [string map {\r "\\r" \n "\\n"} $yybestdata]
		    if {[string length $yymatchout] > 20} {
			set yymatchout [string range $yymatchout 0 16]
			append yymatchout "..."
		    }
                    puts $verbout "jsonscanner: new best match rule $yyruleno, $yybestbegin-$yybestend: `$yymatchout'"
                }
            }
        }
                    
        return $yybestmatch
    }
    
    public method step {} {
        if {$yyindex >= [string length $yydata]} {
            if {$verbose} {
                puts $verbout "jsonscanner: scanner at EOF"
            }
            return [list -1 1 ""]
        }
        
        set yyruleno [yyupdate]
        
        if {$yyruleno == -1} {
            if {$verbose} {
                puts $verbout "jsonscanner: no further match until EOF"
            }
            set yyindex [string length $yydata]
            return [list -1 1 ""]
        }
        
        set yymatch $yymatches($yyruleno)
        set yyindices [lindex $yymatch 0]
        set yystart [lindex $yyindices 0]
        set yyend [lindex $yyindices 1]
        set yytext [string range $yydata $yystart $yyend]
        
        if {$verbose} {
            set yymatchout [string map {\r \\r \n \\n} $yytext]
            if {[string length $yymatchout] > 20} {
                set yymatchout [string range $yymatchout 0 16]
                append yymatchout "..."
            }
            puts $verbout "jsonscanner: best match at $yyindex using rule $yyruleno, $yystart-$yyend: `$yymatchout'"
        }
        
        set yyindex [expr {$yyend + 1}]
        
        for {set yyi 0} {$yyi < [llength $yymatch]} {incr yyi} {
            set yysubidxs  [lindex $yymatch $yyi]
            set yysubbegin [lindex $yysubidxs 0]
            set yysubend   [lindex $yysubidxs 1]
            set $yyi [string range $yydata $yysubbegin $yysubend]
        }
        
        set yyoldstate $yystate
        set yyretcode [catch {
            switch -- $yyruleno {
                1 {

		return [list STRING [string range $yytext 1 [expr [string length $yytext]-2]]]
	
                }
                2 {

		return [list NUMBER $yytext]
	
                }
                3 {

		return [list BOOL $yytext]
	
                }
                4 {
 return STARTBRACE 
                }
                5 {
 return ENDBRACE 
                }
                6 {
 return STARTBRACKET 
                }
                7 {
 return ENDBRACKET 
                }
                8 {
 return COMMA 
                }
                9 {
 return COLON 
                }
                10 {

		## ignore whitespace
	
                }
            }
        } yyretdata]
        
        if {$verbose} {
            if {![string match $yyoldstate $yystate]} {
                puts $verbout "jsonscanner: leaving state $yyoldstate, entering $yystate"
            }
        }
        
        if {$yyretcode == 1} {
            global errorInfo
            set yyerrmsg "script for rule # $yyruleno failed: $yyretdata"
            yyerror $yyerrmsg
            append errorInfo "\n    while executing script for rule # $yyruleno"
            error $yyerrmsg $errorInfo
        }
        
        if {$yyretcode == 2} {
            return [list $yyruleno 1 $yyretdata]
        }
        
        return [list $yyruleno 0 ""]
    }
    
    public method next {} {
        while {42} {
            set yysd [step]
            if {[lindex $yysd 1] == 1} {
                return [lindex $yysd 2]
            }
        }
    }
    
    public method run {} {
        set yyresult [list]
        set yysd [next]
        while {$yysd != ""} {
            lappend yyresult $yysd
            set yysd [next]
        }
        return $yyresult
    }
}


}
