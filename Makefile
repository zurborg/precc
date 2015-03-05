targets=bin/precc

all: $(targets) package.json

lib/%.js: src/%.coffee
	mkdir -p lib
	coffee -sc < $< > $@

bin/%: lib/%.js
	mkdir -p bin
	@echo "#!/usr/bin/env node" > $@
	minify $< >> $@
	chmod +x $@

%.json: %.yml
	yaml2json $< > $@

clean:
	git clean -xdf

install: all
	npm install -g .

.PHONY: all clean install

.SECONDARY:
