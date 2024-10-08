version := $(shell python3 -c 'from jgtfx2console import __version__; print(__version__)')
SHELL := /bin/bash

.PHONY: venv
venv:
	[ -d .venv ] || virtualenv .venv --python=jgtfx2console
	conda activate jgtfx2console

.PHONY: piplocal
piplocal:
	pip install -e '.[dev]'

.PHONY: develop
develop: venv piplocal

.PHONY: lint lint-flake8 lint-isort
lint-flake8:
	flake8 test jgtfx2console
lint-isort:
	isort --check-only -rc jgtfx2console test *.py
lint: lint-flake8 lint-isort

.PHONY: format
format:
	isort -rc jgtfx2console test *.py

.PHONY: test
test:
	coverage run -m py.test
	coverage report

.PHONY: readme_check
readme_check:
	./setup.py check --restructuredtext --strict

.PHONY: rst_check
rst_check:
	make readme_check
	# Doesn't generate any output but prints out errors and warnings.
	make -C docs dummy

.PHONY: clean
clean:
	find . -name "*.pyc" -print0 | xargs -0 rm -f
	rm -Rf dist
	rm -Rf *.egg-info

.PHONY: docs
docs:
	cd docs && make html

.PHONY: authors
authors:
	git log --format='%aN <%aE>' `git describe --abbrev=0 --tags`..@ | sort | uniq >> AUTHORS
	cat AUTHORS | sort --ignore-case | uniq >> AUTHORS_
	mv AUTHORS_ AUTHORS

.PHONY: bump_jgtutils
bump_jgtutils:
	. /opt/binscripts/load.sh && _bump_jgtutils

.PHONY: dist
dist:
	make clean
	make bump_jgtutils
	python -m build

.PHONY: disto
disto:
	make clean
	python setup.py sdist --format=gztar bdist_wheel

.PHONY: pypi-release
pypi-release:
	twine --version
	twine upload -s dist/*

.PHONY: release
release:
	make dist
	git tag -s $(version)
	git push origin $(version)
	make pypi-release

