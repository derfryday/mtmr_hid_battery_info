#!/usr/bin/env bash
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

NOTIFY_INTERVAL_SECONDS=600
WARN_PERCENT=40
ALARM_PERCENT=20
NOTIFY_AT=$WARN_PERCENT
CHECK_FOR="$1"
CHECK_LOG_FILE="/tmp/$CHECK_FOR.check"

# actual battery level
BATT=`ioreg -c AppleDeviceManagementHIDEventService -r -l | grep -i $CHECK_FOR -A 20 | grep BatteryPercent | cut -d= -f2 | cut -d' ' -f2`
function get_batt_colour {
  COLOUR="\033[30;42m"
  if [ $1 -lt $WARN_PERCENT ]; then
    COLOUR="\033[30;43m"
  fi
  if [ $1 -lt $ALARM_PERCENT ]; then
    COLOUR="\033[39;41m"
  fi
  echo $COLOUR
}

NOTIFY_AGAIN=$(cat $CHECK_LOG_FILE 2>/dev/null)
if [ -z $NOTIFY_AGAIN ]; then
  NOTIFY_AGAIN=$(( $(date +%s) - 10 ))
fi

if [ ! -z "$BATT" ]; then
  COLOUR=$(get_batt_colour $BATT)
  if [[ "${CHECK_FOR}" == "mouse" ]]; then
    echo -e "${COLOUR}🐭${BATT}%"
  else
    echo -e "${COLOUR}🎹${BATT}%"
  fi
fi

if [ $NOTIFY_AGAIN -lt $(date +%s) ]; then
    if (( ${BATT} < ${NOTIFY_AT} )); then
        osascript -e "display notification \"$CHECK_FOR battery is at ${BATT}%.\" with title \"$CHECK_FOR Battery Low\""
    fi
    echo $(( $(date +%s) + $NOTIFY_INTERVAL_SECONDS )) > "$CHECK_LOG_FILE"
fi