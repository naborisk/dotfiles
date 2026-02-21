typeset -a sources

sources=(
    $HOME/.zsh/init.zsh

    $HOME/.zsh/options.zsh
    $HOME/.zsh/telemetry.zsh
    $HOME/.zsh/aliases.zsh
    $HOME/.zsh/zinit.zsh
    $HOME/.zsh/path.zsh
    $HOME/.zsh/completions.zsh
    $HOME/.zsh/plugin-options.zsh

    $HOME/.fzf.zsh

    /usr/share/fzf/key-bindings.zsh
    /usr/share/fzf/completion.zsh

    /usr/share/doc/fzf/examples/key-bindings.zsh
    /usr/share/doc/fzf/examples/completion.zsh

    $HOME/.zshrc.local
)

for source in $sources; do
    [ -e $source ] && source $source
done


if command -v brew > /dev/null; then
    _brew_prefix="${HOMEBREW_PREFIX:-$(brew --prefix)}"
    _fzf_version="$(fzf --version 2>/dev/null | cut -d ' ' -f 1)"

    if [[ -n "$_fzf_version" ]]; then
        sources=(
            "$_brew_prefix/Cellar/fzf/$_fzf_version/shell/key-bindings.zsh"
            "$_brew_prefix/Cellar/fzf/$_fzf_version/shell/completion.zsh"
        )

        for source in $sources; do
            [ -e $source ] && source $source
        done
    fi

    unset _brew_prefix _fzf_version
fi
