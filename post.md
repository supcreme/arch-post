1. Refresh pacman keys

   ```bash
   sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys && sudo pacman -Syy
   ```

   Main packages:

```bash
sudo pacman -S pulseaudio pulseaudio-alsa firefox git mousepad unzip unrar vlc lightdm lightdm-gtk-greeter i3-gaps i3lock i3status dmenu engrampa wget ntfs-3g lxappearance ttf-roboto ttf-hack ttf-twemoji feh nomacs
```

Nvidia drivers:

```bash
sudo pacman -S nvidia nvidia-settings nvidia-utils opencl-nvidia opencl-headers lib32-nvidia-utils lib32-opencl-nvidia
```

Services:

```bash
sudo systemctl start dhcpcd.service

sudo systemctl stop dhcpcd.service
sudo systemctl disable dhcpcd.service
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm.service
```

fonts:

```bash
pacman -S --asdeps --needed cairo fontconfig freetype2
```

xorg:

```bash
pacman -S xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput
```

 Install oh-my-zsh :

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

