#!/sbin/env sh
set -e
AUTHOR="@atahabaki"
PROGRAM="commander"
VERSION="v0.5.0"
ABBR="Basic Shell Script 4 Recovery Operations..."

BOLD="\033[1m"
BOLDB="\033[1;34m"
BOLDR="\033[1;31m"
BOLDG="\033[1;32m"
BOLDY="\033[1;33m"
NORMAL="\033[0m"
OK="${BOLDG}[OK]${NORMAL}"
ERR="${BOLDR}[ERR]${NORMAL}"
WRN="${BOLDY}[WRN]${NORMAL}"

RECOVERY_CMD="/cache/recovery/command"

intro() {
	echo -e "${BOLDB}${PROGRAM}${NORMAL} version ${BOLDG}${VERSION}${NORMAL} by ${BOLDR}${AUTHOR}${NORMAL}"
	echo -e "${BOLD}${ABBR}${NORMAL}\n"
}

print_err() {
	if [ $# -eq 1 ]
	then
		echo -e "${ERR} $1"
	else
		echo -e "${ERR} Unknown error occured!"
	fi
}

print_ok() {
	if [ $# -eq 1 ]
	then
		echo -e "${OK} $1"
	else
		echo -e "${OK} Everything is fine!"
	fi
}

print_wrn() {
	if [ $# -eq 1 ]
	then
		echo -e "${WRN} $1"
	else
		echo -e "${WRN} Something idk happenening!"
	fi
}

wipe_cache() {
	echo "wipe cache" >> $RECOVERY_CMD && print_ok "wipe cache command added to que." || print_err "appending failed (wipe cache)"
}

wipe_system() {
	echo "wipe system" >> $RECOVERY_CMD && print_ok "wipe system command added to que." || print_err "appending failed (wipe system)"
}

wipe_dalvik() {
	echo "wipe dalvik" >> $RECOVERY_CMD && print_ok "wipe dalvik command added to que." || print_err "appending failed (wipe system)"
}

wipe_data() {
	echo "wipe data" >> $RECOVERY_CMD && print_ok "wipe data command added to que." || print_err "appending failed (wipe data)"
}

install_file() {
	local filepath
	echo "Type file's path:"
	read filepath
	#echo "install $filepath" >> $RECOVERY_CMD && print_ok "install file added to que." || print_err "appending failed (install ${filepath})"
	echo "--update_package=$filepath" >> $RECOVERY_CMD && print_ok "install file added to que." || print_err "appending failed (install ${filepath})"
}

print_partition_options() {
	echo -e """
${BOLD}S${NORMAL}ystem
${BOLD}D${NORMAL}ata
${BOLD}R${NORMAL}ecovery
${BOLD}B${NORMAL}oot
Example entries: SDRB, SDR, SR, SD, D, S...
	"""
}

backup_partitions() {
	local partitions backupname
	print_partition_options
	echo "Type partitions:"
	read partitions
	echo "Type backup name:"
	read backupname
	echo "backup ${partitions} ${backupname}" >> $RECOVERY_CMD && print_ok "backup added to que." || print_err "appending failed (backup ${partitions})"
}

restore_partitions() {
	local partitions backupname
	print_partition_options
	echo "Type partitions:"
	read partitions
	echo "Type backup name:"
	read backupname
	echo "backup ${partitions} ${backupname}" >> $RECOVERY_CMD && print_ok "restore added to que." || print_err "appending failed (restore ${partitions})"
}

reboot_to() {
	local reboot2
	echo "Reboot to (recovery|poweroff|bootloader|download):"
	read reboot2
	echo "reboot ${reboot2}" >> $RECOVERY_CMD && print_ok "reboot added to que." || print_err "appending failed (reboot ${reboot2})"
}

main() {
	local operanum
	echo -e """
${BOLD}1)${NORMAL} Wipe cache
${BOLD}2)${NORMAL} Wipe system
${BOLD}3)${NORMAL} Wipe dalvik
${BOLD}4)${NORMAL} Wipe data
${BOLD}5)${NORMAL} Backup
${BOLD}6)${NORMAL} Install file
${BOLD}7)${NORMAL} Restore
${BOLD}8)${NORMAL} Reboot
${BOLD}9)${NORMAL} Quit
Select one of them to operate.
"""
	echo "Operation (1-9):"
	read operanum
	if [ "$operanum" -eq "1" ]
	then
		wipe_cache
	elif [ "$operanum" -eq "2" ]
	then
		wipe_system
	elif [ "$operanum" -eq "3" ]
	then
		wipe_dalvik
	elif [ "$operanum" -eq "4" ]
	then
		wipe_data
	elif [ "$operanum" -eq "5" ]
	then
		backup_partitions
	elif [ "$operanum" -eq "6" ]
	then
		install_file
	elif [ "$operanum" -eq "7" ]
	then
		restore_partitions
	elif [ "$operanum" -eq "8" ]
	then
		reboot_to
	elif [ "$operanum" -eq "9" ]
	then
		print_ok "Operations are:"
		cat $RECOVERY_CMD
		echo "Do you agree? (Y/N):"
		read agreement
		if [ "$agreement" == "N" ]
		then
			rm $RECOVERY_CMD && print_ok "Removed all instructions!"
		fi
		exit 0
	fi
}

intro
while true
do
	main
done
