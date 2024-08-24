sudo pacman -S telegram-desktop awesome git xterm nautilus alacritty nitrogen neovim discord polkit-gnome zsh neofetch --noconfirm

mkdir ~/.config/awesome
ln -s /etc/xdg/awesome/rc.lua ~/.config/awesome/rc.lua

# Install paru
mkdir ~/tmp
git clone https://aur.archlinux.org/paru.git ~/tmp
(cd ~/tmp/paru && makepkg -si --noconfirm)

# Installing paru pkg
paru ttf-iosevka-nerd --noconfirm

# sddm theme
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

# AwesomeWM theme
cp -r config/awesome ~/.config/awesome

# Alacritty theme
cp -r config/alacritty ~/.config/alacritty
sudo echo "neofetch" >> ~/.zshrc

# Firefox theme
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/user.js -o ~/.mozilla/firefox/user.js
mkdir ~/.mozilla/firefox/chrome
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/add.svg -o ~/.mozilla/firefox/chrome/add.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/left-arrow.svg -o ~/.mozilla/firefox/chrome/left-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/right-arrow.svg -o ~/.mozilla/firefox/chrome/right-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userChrome.css -o ~/.mozilla/firefox/chrome/userChrome.css
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userContent.css -o ~/.mozilla/firefox/chrome/userContent.css

echo "\n\n\nSuccessfully installed dotfiles! Have a nice day!"
