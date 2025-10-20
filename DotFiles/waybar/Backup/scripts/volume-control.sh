#!/usr/bin/env bash

# Define functions
print_error() {
  cat <<"EOF"
Usage: ./volumecontrol.sh -[device] <actions>
...valid devices are...
    i   -- input device
    o   -- output device
    p   -- player application
...valid actions are...
    i   -- increase volume [+2]
    d   -- decrease volume [-2]
    m   -- mute [x]
EOF
  exit 1
}

send_notification() {
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
  notify-send -r 91190 "Volume: ${vol}%"
}

notify_mute() {
  mute=$(wpctl get-mute @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
  if [ "$mute" = "true" ]; then
    notify-send -r 91190 "Muted"
  else
    notify-send -r 91190 "Unmuted"
  fi
}

action_volume() {
  case "${1}" in
  i)
    # Increase volume if below 100%
    current_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    if [ "$current_vol" -lt 100 ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
    fi
    ;;
  d)
    # Decrease volume, ensuring it doesn’t drop below 0%
    current_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    if [ "$current_vol" -gt 0 ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
    fi
    ;;
  esac
}

select_output() {
  if [ "$@" ]; then
    desc="$*"
    device=$(wpctl status | grep -A 2 "Audio" | grep -F "$desc" | awk '{print $1}')
    if wpctl set-default "$device"; then
      notify-send -r 91190 "Activated: $desc"
    else
      notify-send -r 91190 "Error activating $desc"
    fi
  else
    wpctl status | grep -A 2 "Audio" | grep "node" | awk -F ': ' '{print $2}' | sort
  fi
}

find_audio_output() {
  wpctl status | grep -A 2 "Audio Output" | grep "node" | awk '{print $1}'
}

find_audio_input() {
  wpctl status | grep -A 2 "Audio Input" | grep "node" | awk '{print $1}'
}

# Evaluate device option
while getopts iops: DeviceOpt; do
  case "${DeviceOpt}" in
  i)
    nsink=$(find_audio_input)
    [ -z "${nsink}" ] && echo "ERROR: Input device not found..." && exit 0
    srce="--default-source"
    ;;
  o)
    nsink=$(find_audio_output)
    [ -z "${nsink}" ] && echo "ERROR: Output device not found..." && exit 0
    srce=""
    ;;
  p)
    nsink=$(playerctl --list-all | grep -w "${OPTARG}")
    [ -z "${nsink}" ] && echo "ERROR: Player ${OPTARG} not active..." && exit 0
    srce="${nsink}"
    ;;
  s)
    # Select an output device
    select_output "$@"
    exit
    ;;
  *) print_error ;;
  esac

done

# Set default variables
shift $((OPTIND - 1))

# Execute action
case "${1}" in
i) action_volume i ;;
d) action_volume d ;;
m) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify_mute && exit 0 ;;
*) print_error ;;
esac

send_notification
