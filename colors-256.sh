#
# Escape codes for 256 colors
#
# Kudos: http://misc.flogisoft.com/bash/tip_colors_and_formatting

for i in {0..255} ; do
    FG_COLOR[${i}]="\x1b[38;5;${i}m"
    BG_COLOR[${i}]="\x1b[48;5;${i}m"
done

function test_colors()
{
    echo "Foreground:"
    for i in {0..255} ; do
        printf "${FG_COLOR[${i}]} %03d " ${i}
        if test $(( ($i + 1) % 16 )) = 0 ; then
            printf "\n"
        fi
    done
    echo "Background:"
    for i in {0..255} ; do
        printf "${BG_COLOR[${i}]} %03d " ${i}
        if test $(( ($i + 1) % 16 )) = 0 ; then
            printf "${BG_COLOR0}\n"
        fi
    done
}
