package provide xjson 0.1

package require jsonscanner 0.1
package require jsonparser 0.1
package require jsonencoder 0.1

namespace eval ::json {
	proc dirtydecode {str} {
		set scanner [::json::jsonscanner #auto]
		set parser [::json::jsonparser #auto -scanner [namespace which -command $scanner]]
		$scanner start $str
		set result [$parser parse]
		itcl::delete object $scanner
		itcl::delete object $parser
		return $result
	}
}
