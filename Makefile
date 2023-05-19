# -*- coding: utf-8 -*-
CANDIDATES := $(wildcard .??*) system
EXCLUDES   := .git .gitignore LICENSE Makefile README.md .DS_Store .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
$(eval $(args):;@:)

.DEFAULT_GOAL := help
.PHONY: help test install asdf deploy all clean

help:
	@echo "make list            Show dot files in this repository"
	@echo "make install         Run install script"
	@echo "make update          Run update script"
	@echo "make system          Configure macOS system (Reboot required)"
	@echo "make asdf            Run asdf install script"
	@echo "make deploy          Deploy dotfiles with GNU Stow"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install:
	@echo "Running install script..."
	./scripts/install.sh
	@echo "Install script finished!!"

update:
	@echo "Running update script..."
	./scripts/update.sh
	@echo "Update script finished!!"

system:
	@echo "Configuring macOS System..."
	./scripts/defaults.sh
	./scripts/system.sh
	@echo "Configuring macOS System completed!!"

asdf:
	@echo "Installing asdf..."
	./scripts/asdf.sh
	@echo "asdf script successfully finished!!"

deploy:
	@echo "Creating symbolic links"
	./scripts/deploy.sh
	@echo "deploy script successfully finished!!"
