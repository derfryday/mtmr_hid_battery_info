# HID Battery Info

Shows Battery Level of Human Input Devices in Touchbar using MTMR

## Information

This script will notify the user every 10 minutes when the Battery level of the keyboard/mouse reaches a certain threshold.
The notification interval and threshold can be changed, see Configuration for more info.

It could look a little something like this
![touchbar screenshot](https://gitlab.adup.euc1.lan/e.freitag/hid-battery-info/-/raw/master/screenshot.png)

## Installation

`git clone git@gitlab.adup.euc1.lan:e.freitag/hid-battery-info.git`

configure MTMR to display the mouse and or keyboard status

```json
  {
    "type": "shellScriptTitledButton",
    "refreshInterval": 4,
    "align": "right",
    "bordered": false,
    "source": {
        "inline": "<SCRIPT_PATH> <DEVICE>"
    }
  },
```
Replace `<SCRIPT_PATH>` with the path to your hid-batt_info.sh.
replace `<DEVICE>` with either `mouse` or `keyboard`.
If you want both device just add the entry 2 times and change the device accordingly.

## Configuration

The Status script can be personalised by changing

```bash
NOTIFY_INTERVAL_SECONDS=600
WARN_PERCENT=40
ALARM_PERCENT=20
NOTIFY_AT=$WARN_PERCENT
CHECK_FOR="$1"
CHECK_LOG_FILE="/tmp/$CHECK_FOR.check"
```
in the script
