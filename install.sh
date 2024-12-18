sudo pacman -Syu
sudo pacman -S emacs telegram-desktop sddm awesome git xterm nautilus alacritty nitrogen vim neovim code polkit-gnome rofi zsh neofetch lxappearance dpkg qt6-5compat loupe scrot cmake picom firefox --noconfirm

# Install yay
mkdir ~/tmp
git clone https://aur.archlinux.org/yay.git ~/tmp/yay
(cd ~/tmp/yay && makepkg -si --noconfirm)

# Installing paru pkgs
yay -S ttf-iosevka-nerd catppuccin-cursors-mocha orchis-theme postman-bin jetbrains-toolbox --noconfirm

# sddm theme
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

# Set wallpaper
cp -r wallpaper ~/

# Themes
cp -r config/* ~/.config
sudo echo "neofetch" >> ~/.zshrc

# Firefox theme
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/user.js -o ~/.mozilla/firefox/user.js
mkdir -p ~/.mozilla/firefox/chrome
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/add.svg -o ~/.mozilla/firefox/chrome/add.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/left-arrow.svg -o ~/.mozilla/firefox/chrome/left-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/right-arrow.svg -o ~/.mozilla/firefox/chrome/right-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userChrome.css -o ~/.mozilla/firefox/chrome/userChrome.css
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userContent.css -o ~/.mozilla/firefox/chrome/userContent.css

# Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Rofi theme
mkdir -p ~/.local/share/rofi/themes
cp rofi/rounded-common.rasi ~/.local/share/rofi/themes/
cp rofi/rounded-nord-dark.rasi ~/.local/share/rofi/themes/

# Volume controller
cp volumeControl /bin/

sudo echo "$(<config/etc.rc.lua )" > /etc/xdg/awesome/rc.lua

echo "Successfully installed dotfiles! Have a nice day!"
systemctl enable sddm
systemctl restart sddm
