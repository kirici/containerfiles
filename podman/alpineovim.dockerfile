FROM alpine:latest

RUN apk --no-cache add --update \
	neovim \
	neovim-doc \
	git \
	curl \
	ripgrep \
	fd \
	fzf \
	python3 \
	go \
	cargo \
	npm \
	shellcheck

RUN git clone --depth 1 https://github.com/AstroNvim/template /root/.config/nvim

RUN nvim --headless +"MasonUpdate" +q &>/dev/null
RUN nvim --headless +"MasonInstall bash-debug-adapter bash-language-server shellcheck" +q &>/dev/null
RUN nvim --headless +"MasonInstall delve gofumpt golangci-lint gopls" +q &>/dev/null
RUN nvim --headless +"MasonInstall python-lsp-server" +q &>/dev/null

RUN curl -fsSL https://github.com/kirici/dotfiles/raw/master/dot_config/nvim/lua/plugins/astrolsp.lua -o /root/.config/nvim/lua/plugins/astrolsp.lua
