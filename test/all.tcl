#!/usr/bin/env tclsh
package require Tcl 8.4
package require tcltest 2.2
::tcltest::configure -testdir \
        [file dirname [file normalize [info script]]]
eval ::tcltest::configure $argv
::tcltest::runAllTests
