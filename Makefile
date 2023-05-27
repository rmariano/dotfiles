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
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		target=$(HOME)/$$f; \
		echo -e "\tCopying $$file -> $$target"; \
		cp -f $$file $$target; \
	done
	mkdir -p $(HOME)/.config

.PHONY: system-deps
system-deps:
	dnf install \
		adobe-source-code-pro-fonts.noarch \
		zsh \
		vim-enhanced \
		git-tools

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
	chsh -s /bin/zsh
	@echo "Restart session for changes to take effect (fonts)"

.PHONY: gnome-conf
gnome-conf:
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
