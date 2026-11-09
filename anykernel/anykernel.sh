### AnyKernel3 Ramdisk Mod Script
## Custom Droidspaces Kernel Installer for Google Pixel 5 / Redbull

### AnyKernel setup
# global properties
properties() { '
kernel.string=Droidspaces Enhanced Kernel for Pixel 5 (Redbull)
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=redfin
device.name2=bramble
device.name3=barbet
device.name4=redbull
supported.versions=11 - 17
'; } # end properties

### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
dump_boot;

write_boot;
## end boot install
