## -- this code was generated automatically -- DO NOT EDIT !

package require Itcl 3.0
package provide jsonparser 0.1
namespace eval ::json {
itcl::class jsonparser {
    public variable scanner ""
    public variable verbose 0
    public variable verbout stderr
    private variable yystate 1
    private variable yysstack {1}
    private variable yydstack {}
    private variable yyreadnext 1
    private variable yylookahead
    private variable yyfinished 0
    private common yytrans
    private common yyredux
    private common yyrules

    array set yytrans {
        1,nt_object 2
        1,start 3
        1,STARTBRACE 4
        4,nt_oitems 5
        4,STRING 8
        4,nt_oitem 23
        5,ENDBRACE 6
        5,COMMA 7
        7,STRING 8
        7,nt_oitem 22
        8,COLON 9
        9,BOOL 10
        9,nt_object 11
        9,nt_array 12
        9,NUMBER 13
        9,STARTBRACKET 14
        9,nt_value 21
        9,STRING 18
        9,STARTBRACE 4
        14,nt_aitems 15
        14,BOOL 10
        14,nt_object 11
        14,nt_array 12
        14,NUMBER 13
        14,nt_value 20
        14,STARTBRACKET 14
        14,STRING 18
        14,STARTBRACE 4
        15,COMMA 16
        15,ENDBRACKET 19
        16,BOOL 10
        16,nt_object 11
        16,nt_array 12
        16,NUMBER 13
        16,nt_value 17
        16,STARTBRACKET 14
        16,STRING 18
        16,STARTBRACE 4
    }

    array set yyredux {
        2 2
        3 0
        4 6
        6 3
        10 12
        11 11
        12 10
        13 9
        14 16
        17 14
        18 8
        19 13
        20 15
        21 7
        22 4
        23 5
    }

    array set yyrules {
        0 {__init__ {start}}
        2 {start {nt_object}}
        3 {nt_object {STARTBRACE nt_oitems ENDBRACE}}
        4 {nt_oitems {nt_oitems COMMA nt_oitem}}
        5 {nt_oitems {nt_oitem}}
        6 {nt_oitems {}}
        7 {nt_oitem {STRING COLON nt_value}}
        8 {nt_value {STRING}}
        9 {nt_value {NUMBER}}
        10 {nt_value {nt_array}}
        11 {nt_value {nt_object}}
        12 {nt_value {BOOL}}
        13 {nt_array {STARTBRACKET nt_aitems ENDBRACKET}}
        14 {nt_aitems {nt_aitems COMMA nt_value}}
        15 {nt_aitems {nt_value}}
        16 {nt_aitems {}}
    }

    constructor {args} {
        eval $this configure $args
    }
    
    public method reset {} {
        if {$verbose} {
            puts $verbout "jsonparser: reset, entering state 1"
        }
        set yystate 1
        set yysstack [list $yystate]
        set yydstack [list]
        set yyreadnext 1
        set yyfinished 0
    }
    
    protected method yyerror {yyerrmsg} {
        puts $verbout "jsonparser: $yyerrmsg"
    }
    
    private method yyshift {yytoken yydata} {
        set yynewstate $yytrans($yystate,$yytoken)
        lappend yysstack $yynewstate
        lappend yydstack $yydata
        
        if {$verbose} {
            puts $verbout "jsonparser: shifting token $yytoken, entering state $yynewstate"
        }
        
        set yystate $yynewstate
    }

    private method yyreduce {yyruleno} {
        set yylhs [lindex $yyrules($yyruleno) 0]
        set yyrhs [lindex $yyrules($yyruleno) 1]
        set yycount [llength $yyrhs]
        set yyssdepth [llength $yysstack]
        set yydsdepth [llength $yydstack]
        
        if {$verbose} {
            puts -nonewline $verbout "jsonparser: reducing rule # $yyruleno: $yylhs -->"
            foreach yytoken $yyrhs {
                puts -nonewline $verbout " "
                puts -nonewline $verbout $yytoken
            }
            puts $verbout ""
        }

        for {set yyi 0} {$yyi < $yycount} {incr yyi} {
            set yyvarname [expr {$yyi + 1}]
            set yyvarval  [lindex $yydstack [expr {$yydsdepth-$yycount+$yyi}]]
            set $yyvarname $yyvarval
        }
        
        set yyretcode [catch {
            switch -- $yyruleno {
                2 {
 return $1 
                }
                3 {

		return [list object $2]
	
                }
                4 {
 return [concat $1 $3] 
                }
                5 {
 return $1 
                }
                6 {
 return {} 
                }
                7 {
 return [list $1 $3] 
                }
                8 {
 return [list string $1] 
                }
                9 {
 return [list number $1] 
                }
                10 {
 return $1 
                }
                11 {
 return $1 
                }
                12 {
 return [list bool $1] 
                }
                13 {
 return [list array $2] 
                }
            }
        } yyretdata]
        
        if {$yyretcode == 0} {
            if {$yycount} {
                set yyretdata $1
            } else {
                set yyretdata ""
            }
        } elseif {$yyretcode == 1} {
            global errorInfo
            set yyerrmsg "script for rule # $yyruleno ($yylhs --> $yyrhs) failed: $yyretdata"
            yyerror $yyerrmsg
            append errorInfo "\n    while executing script for rule # $yyruleno ($yylhs --> $yyrhs)"
            error $yyerrmsg $errorInfo
        }
        
        set yysstack [lrange $yysstack 0 [expr {$yyssdepth-$yycount-1}]]
        set yydstack [lrange $yydstack 0 [expr {$yydsdepth-$yycount-1}]]
        set yystate [lindex $yysstack end]
        
        if {$verbose} {
            puts $verbout "jsonparser: entering state $yystate"
        }
        
        return $yyretdata
    }
    
    public method step {} {
        if {$yyfinished} {
           error "step beyond end of parse"
        }
        
        if {$yyreadnext} {
            set yylookahead [$scanner next]
            set yyreadnext 0
        }
        
        set yyterm [lindex $yylookahead 0]
        set yydata [lindex $yylookahead 1]
        
        if {[info exists yytrans($yystate,$yyterm)]} {
            yyshift $yyterm $yydata
            set yyreadnext 1
            return [list $yyterm $yydata]
        } elseif {[info exists yyredux($yystate)] || \
                [info exists yyredux($yystate,$yyterm)]} {
            if {[info exists yyredux($yystate)]} {
                set yyruleno $yyredux($yystate)
            } else {
                set yyruleno $yyredux($yystate,$yyterm)
            }
            
            set yyreduxlhs [lindex $yyrules($yyruleno) 0]
            set yyreduxdata [yyreduce $yyruleno]
            
            if {$yyreduxlhs == "__init__"} {
                set yyfinished 1
            } else {
                yyshift $yyreduxlhs $yyreduxdata
            }
            return [list $yyreduxlhs $yyreduxdata]
        } else {
            global errorInfo
            set yyerrmsg "parse error reading \"$yyterm\" in state $yystate"
            set errorInfo $yyerrmsg
            append errorInfo "\n    expecting one of:"
            foreach yylaname [array names yytrans $yystate,*] {
                append errorInfo "\n        " [lindex [split $yylaname ,] 1]
            }
            yyerror $yyerrmsg
            error $yyerrmsg $errorInfo
        }
        
        error "oops: unreachable code"
    }
    
    public method parse {} {
        if {$scanner == ""} {
            global errorInfo
            set yyerrmsg "cannot start parsing without a scanner"
            set errorInfo $yyerrmsg
            yyerror $yyerrmsg
            error $yyerrmsg $errorInfo
        }
        
        while {!$yyfinished} {
            set yydata [step]
        }
        
        if {[lindex $yylookahead 0] != ""} {
            global errorInfo
            set yyerrmsg "parser finished, but not at EOF (lookahead: [lindex $yylookahead 0])"
            set errorInfo $yyerrmsg
            yyerror $yyerrmsg
            error $yyerrmsg
        }
        
        return [lindex $yydata 1]
    }
}


}
