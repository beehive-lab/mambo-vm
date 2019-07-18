#!/bin/sh

# unmount the system directories in the rootfs
function unmount_subdirs() {
  # gpg-agent may or may not remain running after setting up the keys in the rootfs
  # it should be harmless to kill the host's gpg-agent; if not running, it is restarted when needed
  sudo killall gpg-agent || true
  sudo umount rootfs/run/
  sudo umount rootfs/dev/
  sudo umount rootfs/proc/
}

# Create the required directories
unmount_subdirs
set -e # from now on, stop on any error
sudo rm -Rf rootfs mnt
mkdir rootfs mnt

# Extract the rootfs archive
cd rootfs
sudo tar xpf ../ArchLinuxARM-aarch64-latest.tar.gz
cd ..

# mount the required host directories
sudo mount -o bind /run/ rootfs/run/
sudo mount -o bind /dev/ rootfs/dev/
sudo mount -t proc none rootfs/proc/

# set up the rootfs
sudo chroot rootfs/ /usr/bin/pacman-key --init
sudo chroot rootfs/ /usr/bin/pacman-key --populate archlinuxarm
sudo chroot rootfs/ /usr/bin/pacman -Syu gcc ruby git make --noconfirm
sudo chroot rootfs/ /usr/bin/su alarm -c "cd /home/alarm && git clone https://github.com/beehive-lab/mambo.git && cd mambo && git submodule init && git submodule update"

#cleanup
unmount_subdirs
sudo rm rootfs/var/cache/pacman/pkg/*.tar.xz
