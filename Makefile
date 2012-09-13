.PHONY: all  clean serve source kevinbeaty mvw
all: source 
	mvw generate

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
	cp -R mvw/doc build/source/mvw
