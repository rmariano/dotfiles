PROJECTS := $(HOME)/projects

.PHONY: all
all: dev-deploy

.PHONY: dev-deploy
dev-deploy:
	@echo "Symlinking dotfiles..."
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		target=$(HOME)/$$f; \
		echo -e "\tLinking $$file -> $$target"; \
		ln -sfn $$file $$target; \
	done

.PHONY: system-deps
system-deps:
	dnf install \
		adobe-source-code-pro-fonts.noarch \
		python-virtualenvwrapper.noarch \
		zsh

.PHONY: hooks
hooks:
	@for proj_hook in $(wildcard $(PROJECTS)/*/.git/hooks); do \
		base=$(CURDIR)/git-hooks/branch_ticket_name.py; \
		target=$$proj_hook/prepare-commit-msg; \
		echo -e "\t Linking $$base -> $$target;"; \
		ln -sfn $$base $$target; \
	done

.PHONY: bootstrap
bootstrap:
	sudo make system-deps
	chsh -s $(shell `which zsh`)
