Buildroot for Boot And Nuke
===========================  
[![](https://img.shields.io/github/downloads/NHellFire/dban/latest/total.svg "Latest version")](https://github.com/NHellFire/dban/releases/latest)
[![](https://img.shields.io/github/downloads/NHellFire/dban/v3.0.1/total.svg)](https://github.com/NHellFire/dban/releases/tag/v3.0.1)
[![](https://img.shields.io/github/downloads/NHellFire/dban/v3.0.0/total.svg)](https://github.com/NHellFire/dban/releases/tag/v3.0.0)
[![](https://img.shields.io/github/downloads/NHellFire/dban/v2.2.8/total.svg)](https://github.com/NHellFire/dban/releases/tag/v2.2.8)


####Donations
-------------

If this is useful to you, donations are appreciated (but entirely optional).

[![Flattr this](https://button.flattr.com/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=NHellFire&url=http%3A%2F%2Fgithub.com%2FNHellFire%2Fdban "Flattr this")  
LTC: LZwDu9ADcy6puJ9FfuqxDAXQRH8Xa9Pswo
BTC: 1F8qZ45rLyF2K6xhYz4kJVbvdEmXXVLxH

----

Step 0: Documentation
---------------------

This is the build framework for DBAN:

   http://buildroot.uclibc.org/

Read and understand the overview before trying to customize DBAN.  
The DBAN source code is given as a buildroot BOARD project.

Start reading here:

&nbsp;&nbsp;&nbsp;&nbsp;buildroot/docs/manual/manual.html

Step 1: Clone source
--------------------

Get a local copy of the DBAN source:

    $ git clone --recursive https://github.com/NHellFire/dban.git


Step 2:  Check Host Compatibility
---------------------------------

Compile the default buildroot project:

    $ cd buildroot
    $ make clean
    $ make defconfig
    $ make

This should create the file:

&nbsp;&nbsp;&nbsp;&nbsp;output/images/rootfs.tar

This command will confirm a successful build:

    $ tar xOf output/images/rootfs.tar ./etc/os-release
    NAME=Buildroot
    VERSION=2015.02-00058-g2c9b079-dirty
    ID=buildroot
    VERSION_ID=2015.02
    PRETTY_NAME="Buildroot 2015.02"

If a host computer cannot compile the default buildroot project, then it cannot 
compile the DBAN buildroot project.


Step 3: Build DBAN
------------------

     $ cd buildroot
     $ make clean
     $ make dban_i586_defconfig
     $ make

Alternatively, `make` from the top directory will clean, compile and generate an ISO for you

This will create the DBAN software in:

&nbsp;&nbsp;output/images

~~Some components are unpackaged and must be built locally.  Use the
environment.sh stub to compile local components.~~


Step 4: Build ISO
------------------

From top directory:

    $ ./master.sh
    


Common Problems
---------------

* The buildroot creates a local targeted toolchain (eg:
  `i586-linux-uclibc-gcc`).  If you are using the host compiler (`/usr/bin/gcc`)
  to produce target binaries, then you are using the buildroot incorrectly.

* The buildroot puts absolute paths in various configuration files.  Always
  start from a clean buildroot, and don't move the buildroot after object files
  are created.

* Some buildroot configuration options are incompatible.  A project may compile
  cleanly but produce a broken target environment.

* Programs that are linked against glibc are runtime incompatible with uclibc,
  even though `ldd` on the host and/or target may say otherwise.

* Microsoft Windows is an incompatible host platform.  This buildroot cannot be
  compiled by Visual Studio.
