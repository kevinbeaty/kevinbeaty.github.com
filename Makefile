SRC=build/kevinbeaty
SRC_PROJECT=$(SRC)/projects
PROJECTS=mvw underarm
JS=theme/public/js
JS_LIB=$(JS)/libs
CSS=theme/public/css
CSS_LIB=$(CSS)/libs

UNDERARM=underarm-0.0.1.min.js

.PHONY: all clean serve generate src testlib

all: generate

clean:
	rm -rf build

serve: src
	mvw

generate: src testlib
	mvw generate

src: $(SRC)/index.md $(SRC_PROJECT)

$(SRC):
	mkdir -p $@

$(SRC)/index.md: README.md | $(SRC)
	cp $< $@

$(SRC_PROJECT): $(PROJECTS:%=$(SRC_PROJECT)/%)
	cp projects/index.md $@

$(SRC_PROJECT)/mvw:
	mkdir -p $@
	cp -R projects/mvw/doc/* $@

$(SRC_PROJECT)/underarm: $(JS)/underarm/$(UNDERARM)
	mkdir -p $@
	cp projects/underarm/README.md $@/index.md 
	cp test/underarm.md $@/tests.md
	cp -R projects/underarm/test/test*.js $(JS)/underarm/tests/

$(JS)/underarm/$(UNDERARM): projects/underarm/build/$(UNDERARM)
	cp $< $@

testlib: $(JS_LIB)/mocha/mocha.js $(CSS_LIB)/mocha/mocha.css \
	$(JS_LIB)/expect/expect.js \
	$(JS)/underarm/tests

$(JS_LIB)/mocha/mocha.js: lib/mocha/mocha.js
	cp $< $@

$(CSS_LIB)/mocha/mocha.css: lib/mocha/mocha.css
	cp $< $@

$(JS_LIB)/expect/expect.js: lib/expect.js/expect.js
	cp $< $@
