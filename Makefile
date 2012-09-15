SRC=build/kevinbeaty
SRC_PROJECT=$(SRC)/projects
PROJECTS=mvw underarm

.PHONY: all clean serve generate src

all: generate

clean:
	rm -rf build

serve: src
	mvw

generate: src
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

$(SRC_PROJECT)/underarm:
	mkdir -p $@
	cp projects/underarm/README.md $@/index.md 
