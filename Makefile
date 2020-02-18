
.PHONY: help

# Shell that make should use
SHELL:=bash

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

# - to suppress if it doesn't exist
-include make.env

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

venv: DARGS?=
venv: ## create python3 venv
	python3 -m venv venv
	# source venv/bin/activate
	# pip install -r requirements.txt

docs-live:
docs-live: ## create live docs
	bash scripts/docs-live.sh


.DEFAULT_GOAL := help
