if status is-interactive
    starship init fish | source
end

if status is-login
    fish_add_path ~/.local/bin
end

if type -q mise
    mise activate fish | source
end

alias ls="exa --icons"
alias ll="exa -la --icons"
alias cat="bat"
alias ff="fastfetch"