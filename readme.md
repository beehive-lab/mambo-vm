Script for building an AArch64 QEMU virtual machine running [Arch Linux ARM](https://archlinuxarm.org/) suitable for using the [MAMBO dynamic binary instrumentation / modification tool](https://github.com/beehive-lab/mambo) on non-ARM machines.

Prebuilt images are available on the [release page](https://github.com/beehive-lab/mambo-vm/releases).


Usage (for the prebuilt images)
===============================

Prerequisites: `qemu-system-aarch64` (e.g. from the `qemu-system-arm` package in Debian / Ubuntu), a SSH client

    mkdir mambo-vm
    cd mambo-vm
    tar xf /path/to/mambo_vm.tar.gz
    ./start_vm.sh

The console will be available in the QEMU window via the View -> serial0 option or via SSH on localhost:5040.

Login credentials:
------------------

    alarm:alarm
    root:root

Make sure you set secure passwords before making the VM accessible via the network.

The MAMBO git repository is already cloned in `/home/alarm/mambo`. You can`cd /home/alarm/mambo` and run `make` to compile it. 
