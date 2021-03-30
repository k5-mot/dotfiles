##
## Makefile
##
##   For installation of dotfiles.
##

## Makefile Path.
MAKEPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
## Configuration Path.
CONFPATH    := $(addsuffix /conf,$(MAKEPATH))
## Copy source (Configurations)
CONFFILES   := $(shell find $(CONFPATH) -type f)
CONFDIRS    := $(shell find $(CONFPATH) -type d)
## Configurations
DOTFILES    := $(subst $(CONFPATH)/,,$(CONFFILES))
DOTDIRS     := $(subst $(CONFPATH)/,,$(CONFDIRS))
## Copy destination (Configurations)
LINKFILES   := $(addprefix $(HOME)/,$(DOTFILES))
LINKDIRS    := $(addprefix $(HOME)/,$(DOTDIRS))

.DEFAULT_GOAL := help

all: ## All operations

list: ## Show dot files in this repos
	@$(foreach val, $(LINKFILES), echo $(val);)

install: ## Create symlink to home directory
	@echo 'Install dotfiles to home directory.'
	@echo $(CONFPATH)
	@echo "CONFDIRS"
	@$(foreach val, $(CONFDIRS), echo $(val);)
	@echo "DOTDIRS"
	@$(foreach val, $(DOTDIRS), echo $(val);)
	@echo "LINKDIRS"
	@$(foreach val, $(LINKDIRS), echo $(val);)
	@echo $(MAKEPATH)
	@$(foreach val, $(LINKDIRS), mkdir -pv $(val);)
	@$(foreach val, $(DOTFILES), ln -sfnv $(CONFPATH)/$(val) $(HOME)/$(val);)

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

reinstall: ## Remove the dot files and Install
	@make clean
	@make install

vscode-extension: ## Install extensions for VSCode
	@bash $(CONFPATH)/.config/Code/install_extension.sh $(CONFPATH)/.config/Code/extension-list

git-userconfig: ## Generate user config for Git
	@cp -rf $(CONFPATH)/.config/git/gitconfig_user_sample $(HOME)/.config/git/gitconfig_user

help: ## Self-documented Makefile
	@echo 'Copyright (c) 2020-2021 k5-mot All Rights Reserved.'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

