pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys && sudo pacman -Syy

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pacman -S pulseaudio pulseaudio-alsa firefox git mousepad unzip unrar vlc lightdm lightdm-gtk-greeter i3-gaps i3lock i3status dmenu rofi dunst arandr engrampa wget ntfs-3g lxappearance ttf-roboto ttf-hack ttf-twemoji feh thunar thunar-volman gvfs tumbler polkit xfce4-power-manager polkit-gnome ffmpegthumbnailer wireguard-tools wireguard-arch openresolv xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput python-pip qemu virt-manager net-tools virtualbox-host-modules-arch virtualbox-guest-iso

pacman -S --asdeps --needed cairo fontconfig freetype2