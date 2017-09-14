# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

HUGO_VERSION = 0.26
HUGO_PLATFORM = Linux-64bit

.PHONY: build server theme help
.DEFAULT_GOAL := help

build: ## Build site
	@hugo

server: ## Serve site
	@hugo server --bind "0.0.0.0" --buildDrafts --buildFuture

theme: ## Update theme via git-submodule
	@git submodule update --remote

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
