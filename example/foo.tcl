#!/usr/bin/env tclsh

lappend auto_path [file join [file dirname [info script]] ..]
#package require jsonscanner
#package require jsonparser
package require xjson


set scanner [::json::jsonscanner #auto]

#set text "23 -42 0 00 0.23 5e-23 true 'blubb' \"bla\" \"\\f\" \"\\uabc9\"\"foo \\\\ \\uabc9\"\n { } \[ \]"
set text "{ \"key\":23, \"key2\": \"foo\", \"obj2\": {\"bla\": \[\"foo\", 23\]}}"
#$scanner start $text
#set tokens [$scanner run]

#$scanner reset
#delete object $scanner

#puts "Tokens:"
#puts $tokens


set parser [::json::jsonparser #auto -scanner $scanner]

$scanner start $text
$parser reset
set result [$parser parse]

puts $result


puts [::json::dirtydecode "{\"foo\":\"boo\"}"]
