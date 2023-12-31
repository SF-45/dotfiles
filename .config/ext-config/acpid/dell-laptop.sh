#!/bin/bash
# Default acpi script that takes an entry for all actions 

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    video/brightnessdown)
        DISPLAY=:0 su sf -c 'xbacklight -10'
    ;;
    video/brightnessup)
        DISPLAY=:0 su sf -c 'xbacklight +10'
    ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                #DISPLAY=:0 su sf -c 'xrandr --output eDP1 --off'
                DISPLAY=:0 su sf -c 'xbacklight -set 0'
                #echo -n 0 > /sys/class/backlight/intel_backlight/brightness
                echo
                ;;
            open)
                logger 'LID opened'
                #DISPLAY=:0 su sf -c 'autorandr -c'
                DISPLAY=:0 su sf -c 'xbacklight -set 100'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
        esac
    ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
