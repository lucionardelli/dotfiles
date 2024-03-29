#!/bin/bash -e

for i in "$@"
do
case $i in
    -e|--enable)
    ENABLE=1
    shift # past argument with no value
    ;;
    -d|--disable)
    DISABLE=1
    shift # past argument with no value
    ;;
    -s=*|--sleep=*)
    SLEEP_S="${i#*=}"
    shift # past argument=value
    ;;
    -h|--help)
    HELP=1
    shift # past argument with no value
    ;;
    *)
    # unknown option
    echo "Unknown option $i"
    exit
    ;;
esac
done

if [[ -n $HELP ]]; then
    echo
    echo "Enable (-e|--enable) or disable (-d|--disable) touchpad."
    echo "Examples"
    echo "\tSleep 10 secs, then enable:"
    echo "\t\t$0 --enable --sleep=10"
    echo
    echo "\tDisable:"
    echo "\t\t$0 --disable"
    echo
    exit
fi


if [[ -z $ENABLE ]] && [[ -z $DISABLE ]]; then
    echo "Missing command, either enable or disable. aborting..."
    exit
else
    TOUCHPAD=`xinput --list --name-only | grep -i touch` || true
    if [[ -z $TOUCHPAD ]]; then
        echo "Couldn't get Touchpad version. Try running xinput and manually editing this file"
        exit 1
    fi
    if [[ -n $SLEEP_S ]]; then
        sleep $SLEEP_S
    fi

    if [[ -n $ENABLE ]]; then
        xinput set-prop "$TOUCHPAD" "Device Enabled" 1
    else
        xinput set-prop "$TOUCHPAD" "Device Enabled" 0
    fi
fi
echo "Success!"
exit 0
