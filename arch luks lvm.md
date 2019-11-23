```
Installation procedure (encrypted lvm on EFI):


Use wifi-menu to connect to network


Visit https://www.archlinux.org/mirrorlist/ on another computer, generate mirrorlist


Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers


# Update package indexes: 
pacman -Sy 

# Install some stuf
pacman -S python reflector

# Add mirrors to mirrorlist  via reflector
reflector --country Russia --country Sweden --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist


# create 400M boot partition and rest LVM in cfdidk

mkfs.fat -F32 /dev/sda1

# Set up encryption

cryptsetup -y -v luksFormat /dev/sda2
cryptsetup open --type luks /dev/sda2 luks

# Set up lvm:

pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate -L 100GB vg0 -n lv_root
lvcreate -L 90GB vg0 -n lv_home
lvcreate -l 100%FREE vg0 -n lv_swap

# modprobe dm_mod
# vgscan
# vgchange -ay

# Format LVM partitions

mkfs.ext4 /dev/vg0/lv_root
mkfs.ext4 /dev/vg0/lv_home
mkswap /dev/vg0/lv_swap

mkdir /mnt/boot
mkdir /mnt/home

# Mount the new system

mount /dev/vg0/lv_root /mnt
mount /dev/sda1 /mnt/boot
mount /dev/vg0/lv_home /mnt/home
swapon /dev/vg0/lv_swap

pacstrap -i /mnt base base-devel linux linux-headers nano vim lvm2 linux-firmware networkmanager dhcpcd yay

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# Set root password
passwd 

# Generate locale
nano /etc/locale.gen (uncomment en_US.UTF-8)
locale-gen
locale > /etc/locale.conf

#localectl set-locale LANG=en_US.UTF-8

# Set hostname
echo dex > /etc/hostname

# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

# Generate /etc/adjtime
hwclock --systohc --utc

# Add user
nano /etc/sudoers
# Uncomment to allow members of group wheel to execute any command %wheel ALL=(ALL) ALL
useradd -m -g users -G wheel myuser
passwd myuser

#Add your newly created user to the wheel group by running
#usermod -aG wheel <username>


-------------------------------------------
# Edit /etc/mkinitcpio.conf and add encrypt lvm2 in between block and filesystems
# HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)

mkinitcpio -p linux

------------------------------------------------------------------------------------------
# INSTALL BOOTLOADER

bootctl --path=/boot install

# Configure bootloader
# Create /boot/loader/entries/arch.conf

title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options cryptdevice=UUID=deviceUUID:luks root=/dev/vg0/lv_root


# options cryptdevice=UUID=<YOUR-PARTITION-UUID>:lvm:allow-discards resume=/dev/mapper/vg0-swap root=/dev/mapper/vg0-root rw quiet

# you can add UUID in VIM ":read ! blkid /dev/sda2"

#Edit /boot/loader/loader.conf
timeout 7
default arch
editor 0


exit
umount -a or umount -R /mnt
swapoff -a
reboot
```





```
you can open luks partition with command
cryptsetup open --type luks /dev/sda2/luks
```

