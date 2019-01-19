# Linux Shell Configuration Files
---------------------------------

The list of my configuration files. Each file should be dropped into its
corresponding path.


## Use

1. Clone the repository, and then
2. Run the following command to setup the configuration files:

```console
$ make dev-deploy
```

## Extensibility & custom configuration
If there exists a file at ``~/.extra``, this configuration will be loaded after
all the default values, making the configuration extensible. Here, custom
extensions, aliases, functions, that aren't going to be tracked or versioned
can be written, potentially overriding default values.

This will link the files from the downloaded path to the home directory.

# Dependencies

* A monospace font compatible with the zsh characters: `adobe-source-code-pro-fonts.noarch`
* Virtualenvwrapper (for Python development): `python-virtualenvwrapper.noarch`
* Zsh


## Vim

This configuration has its own repository, for my custom `Vim`
configuration check out [rmariano vim](https://github.com/rmariano/vim-config).
