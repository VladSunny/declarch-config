if status is-interactive
    starship init fish | source
end

alias ls="exa --icons"
alias ll="exa -la --icons"
alias cat="bat"
alias ff="fastfetch"