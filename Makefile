MASTER=projects/kevinbeaty.github.com
.PHONY: all clean serve generate source kevinbeaty mvw
all: generate

clean:
	rm -rf build

serve: source
	mvw

generate: source
	mvw generate
	mv site/*.html $(MASTER)
	cp -R site/css $(MASTER) && rm -rf site/css
	cp -R site/js $(MASTER) && rm -rf site/js

source: kevinbeaty mvw

build/source:
	mkdir -p $@

kevinbeaty: build/source/index.md

build/source/index.md: README.md | build/source
	cp $< $@

mvw: build/source/mvw

build/source/mvw: | build/source
	cp -R projects/mvw/doc build/source/mvw
