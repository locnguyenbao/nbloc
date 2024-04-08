GAEDIR=$(HOME)/lib/google_appengine/1.6.4

dist: dist/nbl.js dist/nbl.min.js

dist/nbl.js: lib
	mkdir -p dist
	node_modules/browserify/bin/cli.js lib/nbl.js -v -o dist/nbl.js

dist/nbl.min.js: dist/nbl.js
	mkdir -p dist
	bin/closure-compile.sh < dist/nbl.js > dist/nbl.min.js

lib: src/*
	node_modules/coffee-script/bin/coffee -c -o lib src
	touch lib

cdn: dist
	$(GAEDIR)/appcfg.py update .

test: lib
	@NODE_PATH=lib expresso
	node_modules/coffee-script/bin/coffee poormanstest.coffee

docs: example/*
	./node_modules/.bin/docco example/*.js

serve: dist
	python -m SimpleHTTPServer 8000

.PHONY: test serve
