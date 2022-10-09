#!/bin/sh

# Mechwarrior 2 will revert the key mapping files to default unless you make
# them read-only. So, opens ACLs, edits the files, then closes the ACLs.
# See: http://www.mech2.org/forum/viewtopic.php?f=7&t=2051

PROG=$(basename $0)
SYSTEM=$(uname)

# INPUT_MAP_FILE=/tank/raid1/backup/games/all/mechwarrior2/drive_c/MECH2/INPUT.MAP
# GAMEKEY_MAP_FILE=/tank/raid1/backup/games/all/mechwarrior2/drive_c/MECH2/GAMEKEY.MAP
INPUT_MAP_FILE=INPUT.MAP
GAMEKEY_MAP_FILE=GAMEKEY.MAP

if [ "$SYSTEM" = FreeBSD ]; then
	UNLOCK_CMD='chflags noschg'
	LOCK_CMD='chflags schg'
elif [ "$SYSTEM" = Linux ]; then
	UNLOCK_CMD='chattr -i'
	LOCK_CMD='chattr +i'
else
	echo "$PROG: error: unknown uname: $(uname)" >&2
	exit 1
fi

unlock_files ()
{
    sudo $UNLOCK_CMD $INPUT_MAP_FILE $GAMEKEY_MAP_FILE
}

edit_files ()
{
    vim -O $INPUT_MAP_FILE $GAMEKEY_MAP_FILE
}

lock_files ()
{
    sudo $LOCK_CMD $INPUT_MAP_FILE $GAMEKEY_MAP_FILE
}

list_files ()
{
    if [ "$SYSTEM" = FreeBSD ]; then
	    ls -lo $INPUT_MAP_FILE $GAMEKEY_MAP_FILE
    elif [ "$SYSTEM" = Linux ]; then
	    lsattr $INPUT_MAP_FILE $GAMEKEY_MAP_FILE
    fi
}

if [ "$1" = '-u' ]; then
    unlock_files
    list_files
    exit
elif [ "$1" = '-l' ]; then
    lock_files
    list_files
    exit
else
    unlock_files
    edit_files
    lock_files
    list_files
fi

