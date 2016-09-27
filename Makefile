all: dev-deploy

dev-deploy:
	@echo "Symlinking dotfiles..."
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		target=$(HOME)/$$f; \
		echo -e "\tLinking $$file -> $$target"; \
		ln -sfn $$file $$target; \
	done

system-deps:
	dnf install \
		adobe-source-code-pro-fonts.noarch \
		python-virtualenvwrapper.noarch \
		zsh

bootstrap:
	sudo make system-deps
	chsh -s $(shell `which zsh`)

gnome-conf:
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"


.PHONY: all dev-deploy gnome-conf system-deps
