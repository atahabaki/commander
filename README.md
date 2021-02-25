# Commander

Commander is a ADB (Android Debug Bridge) tool for lazies. It is
commonly used for Recovery stuff, such as:

* Wipe a partition...
* Backup...
* Restore...
* Install flashable zip file...

Currently, this're all what you can do with this.

Tested on `Google GM5 Plus (shamrock)`...

## How to use?

### With Root

Run the below script in a terminal emulator (eg. Termux)

```bash
git clone https://github.com/atahabaki/commander
cd commander
su -c ./commander.sh
```

If root provider of yours, asks permission, grant it, then use the menu printed on the terminal emulator as described.

### Without Root

Download this repo or clone. Reboot your phone/tablet into recovery (it should be custom and should support OpenRecoveryScript).

Open terminal emulator in recovery or plug your phone to pc for ADB.

#### With ADB

```bash
adb shell "cd /path/to/downloaded/repo/commander"
adb shell "su -c \"sh ./commander.sh\""
```

#### Without ADB

```bash
cd /path/to/downloaded/repo/commander
su -c ./commander.sh
```

### Navigating in Menu?

It's simple just type what examples are saying...
