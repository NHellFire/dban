Buildroot for Boot And Nuke
===========================

&nbsp;

![](https://img.shields.io/github/downloads/NHellFire/dban/latest/total.svg "Latest version")
![](https://img.shields.io/github/downloads/NHellFire/dban/v3.0.0/total.svg)
![](https://img.shields.io/github/downloads/NHellFire/dban/v2.2.8/total.svg)

&nbsp;

Step 1: Documentation
---------------------

This is the build framework for DBAN:

   http://buildroot.uclibc.org/

Read and understand the overview before trying to customize DBAN.  
The DBAN source code is given as a buildroot BOARD project.

Start reading here:

&nbsp;&nbsp;&nbsp;&nbsp;buildroot/docs/buildroot.html


Step 2:  Check Host Compatibility
---------------------------------

Compile the default buildroot project:

    $ cd buildroot
    $ make clean
    $ make defconfig
    $ make

This should create the file:

&nbsp;&nbsp;&nbsp;&nbsp;buildroot/binaries/uclibc/rootfs.i686.ext2

This command will confirm a successful build:

     $ e2tail buildroot/binaries/uclibc/rootfs.i686.ext2:/etc/br-version
     0.10.0-svn-svn24295

If a host computer cannot compile the default buildroot project, then it cannot 
compile the DBAN buildroot project.


Step 3: Build DBAN
------------------

     $ cd buildroot
     $ make clean
     $ make dban_defconfig
     $ make

This will create the DBAN software in:

&nbsp;&nbsp;output/images

~~Some components are unpackaged and must be built locally.  Use the
environment.sh stub to compile local components.~~


Step 4: Build ISO
------------------

From toplevel:

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

* An `svn update` in buildroot often breaks local projects.  Make the given
  source tree work before updating components.

* Microsoft Windows is an incompatible host platform.  This buildroot cannot be
  compiled by Visual Studio.
