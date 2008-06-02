package provide jsonencoder 0.1

namespace eval ::json {
	proc encode {obj} {
		foreach {type value} $obj {
			switch $type {
				object {
					set acc {}
					foreach {key element} $value {
						set enc [encode $element]
						lappend acc "\"$key\":$enc"
					}
					set acc [join $acc ","]
					return "{$acc}"
				}
				number { return $value }
				bool { return  $value }
				array {
					set acc {}
					foreach {element} $value {
						lappend acc [encode $element]
					}
					set acc [join $acc ","]
					return "\[$acc\]"
				}
				string { return "\"$value\"" }
			}
		}
	}
}