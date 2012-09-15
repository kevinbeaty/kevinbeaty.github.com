SRC=build/kevinbeaty
SRC_PROJECT=$(SRC)/projects
PROJECTS=mvw underarm storyturtle
JS=theme/public/js
JS_LIB=$(JS)/libs
CSS=theme/public/css
CSS_LIB=$(CSS)/libs

UNDERARM=underarm-0.0.1.min.js

STORYTURTLE=storyturtle-0.0.5.min.js
STORIES:=$(wildcard projects/storyturtle/stories/*.txt)

.PHONY: all clean serve generate src testlib

all: generate

clean:
	rm -rf build

serve: src
	mvw

generate: src testlib
	mvw generate

# mocha, expect
testlib: $(JS_LIB)/mocha/mocha.js $(CSS_LIB)/mocha/mocha.css \
	$(JS_LIB)/expect/expect.js \
	$(JS)/underarm/tests

$(JS_LIB)/mocha/mocha.js: lib/mocha/mocha.js
	cp $< $@

$(CSS_LIB)/mocha/mocha.css: lib/mocha/mocha.css
	cp $< $@

$(JS_LIB)/expect/expect.js: lib/expect.js/expect.js
	cp $< $@

# Sources
src: $(SRC)/index.md $(SRC_PROJECT)

$(SRC):
	mkdir -p $@

$(SRC)/index.md: README.md | $(SRC)
	cp $< $@

$(SRC_PROJECT): $(PROJECTS:%=$(SRC_PROJECT)/%)
	cp projects/index.md $@

# mvw
$(SRC_PROJECT)/mvw:
	mkdir -p $@
	cp -R projects/mvw/doc/* $@

# underarm
$(SRC_PROJECT)/underarm: $(JS)/underarm/$(UNDERARM)
	mkdir -p $@
	cp projects/underarm/README.md $@/index.md
	cp test/underarm.md $@/tests.md
	cp -R projects/underarm/test/test*.js $(JS)/underarm/tests/

$(JS)/underarm/$(UNDERARM): projects/underarm/build/$(UNDERARM)
	cp $< $@

# storyturtle
$(SRC_PROJECT)/storyturtle: $(JS)/storyturtle/$(STORYTURTLE) \
	$(SRC_PROJECT)/storyturtle/index.md \
	$(addprefix $(SRC_PROJECT)/storyturtle/, $(notdir $(STORIES:.txt=.md)))

$(JS)/storyturtle/$(STORYTURTLE): projects/storyturtle/dist/$(STORYTURTLE)
	cp $< $@

$(SRC_PROJECT)/storyturtle/index.md: projects/storyturtle/README.md
	mkdir -p $(dir $@)
	cp $< $@

$(SRC_PROJECT)/storyturtle/%.md: projects/storyturtle/stories/%.txt
	echo 'theme:storyturtle' > $@
	echo '<div><textarea cols="30" rows="15" id="storyturtle-story" data-story="$(notdir $(basename $@))">' >> $@
	cat $< >> $@
	echo '</textarea></div>' >> $@
