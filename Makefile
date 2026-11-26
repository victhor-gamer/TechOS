PYTHON ?= python3

.PHONY: run test build clean

run:
	$(PYTHON) apps/techos-welcome/src/techos_welcome.py

test:
	$(PYTHON) -m unittest discover -s tests -v

build:
	sh scripts/build-deb.sh

clean:
	rm -rf build/
