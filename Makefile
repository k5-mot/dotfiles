## Change subdirectory by OS.
OS          := linux
MAKEPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTPATH     := $(addsuffix /$(OS)/,$(MAKEPATH))
## List of dotfiles.
DOTFILES    := $(subst $(DOTPATH),,$(shell find $(DOTPATH) -type f))
SELECTFILES := $(subst $(MAKEPATH)/,,$(shell find $(DOTPATH) -type f))
## List of directory for dotfiles.
DOTDIRS     := $(subst $(DOTPATH),,$(shell find $(DOTPATH) -type d))
LINKDIRS    := $(addprefix $(HOME)/,$(DOTDIRS))

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(SELECTFILES), ls -dF $(val);)

install: ## Create symlink to home directory
	@echo 'Install dotfiles to home directory.'
	@$(foreach val, $(LINKDIRS), mkdir -pv $(val);)
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(addprefix $(OS)/,$(val))) $(HOME)/$(val);)

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

reinstall:
	@make clean
	@make install

vscode-extension:
	@bash $(MAKEPATH)/linux/.config/Code/install_extension.sh $(MAKEPATH)/linux/.config/Code/extension-list

help: ## Self-documented Makefile
	@echo 'Copyright (c) 2020 k5-mot All Rights Reserved.'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
