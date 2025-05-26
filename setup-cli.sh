#! /bin/sh

echo "Cloning repository. This WILL take a while."
git clone https://www.github.com/alexZeLoCO/dotfiles.git

echo "Repository cloned. Copying configuration."

cp dotfiles/.vim ~/ -dr
cp dotfiles/.config/fish ~/.config/ -dr

echo "Configuration copied. Use your package manager to install vim, npm and fish."
echo "(sudo apt install vim npm fish / sudo pacman -S vim npm fish / sudo dnf install vim npm fish)"
echo "Then use chsh to select /usr/bin/fish as your default shell"
