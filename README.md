# Mechwarrior 2

`GAMEKEY.MAP` and `INPUT.MAP` are the keybinding files for MW2.  These
files are always overwritten with the defaults unless you make them
unwritable.  The `editmaps.sh` script can be used to toggle the
immutable ACL on the files.  My MW2 install is on ext4 on Linux and
ZFS on my FreeBSD NAS, so `editmaps.sh` implements the appropriate
ACL-setting method for those OSes.



