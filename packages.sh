sudo dnf install zsh gnome-tweaks zathura zathura-pdf-mupdf zathura-pdf-poppler nodejs nnn vulkan-loader vulkan-loader.i686 util-linux-user neofetch emacs
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh
