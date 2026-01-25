# Run after base install and chroot
```
pacman -S --needed git chezmoi

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si

yay -S metapac

chezmoi init --apply https://github.com/VladSunny/declarch-config.git

metapac sync
```