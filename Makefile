all: index.html

%.html: src/%.md
	mkdir -p build/
	cp src/style.css build/
	pandoc -s --template=src/html5.template -c style.css -o build/$@ $<
