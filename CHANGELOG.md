### Unreleased v3.0.2:

- Automatically shutdown 1 hour after successful wipe

- Add PowerPC build

- Update MBR code with some parts of #13

- dwipe: Check for failed verification

- kernel: Disable network autoconfiguration

- skeleton:
    - Fix cciss devices not being detected

&nbsp;
&nbsp;

### Released v3.0.1, 12th May 2015:

- Allow turning disk fingerprinting off

- dwipe:
	- Correct throughput formatting
	- Add configuration menu

- init.d: Call `reset` instead of resetting terminal manually

- Write dummy bootcode to wiped devices containing info (closes #3)

- skeleton:
	- Change to press enter to shutdown
	- Hide dd output when writing MBRs
	- Have syslogd erase log every 20MB
	- Fix TFTP log upload  
	  Specify: tftp=x.x.x.x:69 in kernel args  
          Default TFTP port (69) will be used if omitted.
	- Automatically configure network
	- Only attempt to write MBR if device is still attached

&nbsp;  
&nbsp;  

### Released v3.0.0, 1st May 2015:

- Updated to buildroot 2015.02 (kernel 3.18.x)

- Update ISOLINUX to v6.03

- Import lshw SVN r2575 (Fixes #4)
  Fixes crashing with certain devices
  Appears to have been caused by long serial numbers

- dwipe: Fix reporting process crashed after successful wipe
         when not wiping all disks

- kernel:
	- Enable HPSA driver
	- Enable filesystem drivers
	- Enable networking drivers
	- Enable DHCP and BOOTP support


- skeleton:
	- Log all udev messages to file
	  So that dwipe doesn't get typed over when unplugging a USB device

	- Change to press any key to shutdown after wiping (run "poweroff")
	  Previously was hold power button

	- Check for CCISS devices as well

	- lshw: Dump disk info to sourceable file
	  Will later be used to generate bootcode with wipe status

	- Remove lshw binary
	  Buildroot provides a package now

	##### These haven't been tested, but *should* work
	- Save log in /DBANLOG/ on specified TFTP server
	  Specify: tftp=x.x.x.x:69 in kernel arguments
	  Default TFTP port (69) will be used if omitted.

	- Save log to FAT filesystems containing DBANLOG folder in root.

&nbsp;  
&nbsp;  
  
### Released 2.2.8, November 22nd, 2013:

- Buildroot updated to 2012.02 (Thanks to sourceforge user HellFire / github NHellFire!).

- /bin/sh replaced by /bin/bash.

- Kernel messages are not shown any more on top of DBAN GUI.

- Dwipe (erasure engine) is integrated as a package to the Buildroot.

- "nousb" option added in autonuke mode (in auto mode USB sticks/hdds will not be erased. No more accidents!).

- Fixed erasure failure if one of the disks was unplugged while in disk selection screen.

- Card reader/unknown device erasure crash is fixed.

&nbsp;  
&nbsp;  
  
### Released 2.2.7, September 10th, 2012:

- Updated/fixed packages: jpeg.

- Issues resolved (http://bugs.uclibc.org):

	- #3137285: hangs on starting isolinux

	- #3151269: dban-2.2.6_i586.iso "No Configuration File Found" errors
