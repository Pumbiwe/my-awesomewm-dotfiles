sudo pacman -S telegram-desktop awesome xterm nautilus alacritty nitrogen neovim discord
mkdir ~/.config/awesome
ln -s /etc/xdg/awesome/rc.lua ~/.config/awesome/rc.lua

# sddm theme
sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

