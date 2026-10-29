PROJECTS := $(HOME)/code

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
	mkdir -p $(HOME)/.config
	ln -sfn $(CURDIR)/custom-config.zsh $(HOME)/.oh-my-zsh/custom/custom-config.zsh

.PHONY: remove
remove:
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		rm -f $(HOME)/$$f; \
	done

.PHONY: deploy
deploy:
	@echo "Copying dotfiles..."
	cp fish/functions/*.fish ~/.config/fish/functions

.PHONY: hooks
hooks:
	find "$(PROJECTS)" -type d -exec test -d '{}/.git' \; -prune -exec sh -c ' \
		proj_hook="$$1/.git/hooks"; \
		if [ ! -d "$$proj_hook" ]; then exit 0; fi; \
		base="$(CURDIR)/git-hooks/branch_ticket_name.py"; \
		target="$$proj_hook/prepare-commit-msg"; \
		echo -e "\t Linking $$base -> $$target;"; \
		ln -sfn "$$base" "$$target"; \
	' sh {} \;
