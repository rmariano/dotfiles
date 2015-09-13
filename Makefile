all: deploy

deploy:
	# Symlink dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		echo Linking $$f; \
		ln -sfn $$file $(HOME)/$$f; \
	done

.PHONY: all deploy
