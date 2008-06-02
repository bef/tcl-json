.PHONY: clean


generate: jsonscanner.tcl jsonparser.tcl

jsonscanner.tcl: gen_jsonscanner.tcl
	./gen_jsonscanner.tcl

jsonparser.tcl: gen_jsonparser.tcl
	./gen_jsonparser.tcl

clean:
	rm -f jsonscanner.tcl jsonparser.tcl

test:
	@echo "foo"

install:
	@echo "foo"

