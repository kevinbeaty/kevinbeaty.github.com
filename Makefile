.PHONY: all  clean serve source kevinbeaty mvw
all: source 
	mvw generate
	mv site/*.html projects/kevinbeaty.github.com
	cp -R site/css projects/kevinbeaty.github.com && rm -rf site/css
	cp -R site/js projects/kevinbeaty.github.com && rm -rf site/js

clean:
	rm -rf build

serve: source
	mvw

source: kevinbeaty mvw

build/source:
	mkdir -p $@

kevinbeaty: build/source/index.md

build/source/index.md: README.md | build/source
	cp $< $@

mvw: build/source/mvw

build/source/mvw: | build/source
	cp -R projects/mvw/doc build/source/mvw
