# Run after base install and chroot
pacman -S --needed git chezmoi paru
chezmoi init --apply git@github.com:YOUR_USERNAME/arch-dotfiles.git
metapac sync