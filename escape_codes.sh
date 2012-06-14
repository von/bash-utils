#!/bin/bash
#
# VT100 Escape codes
#
# Kudos:
# http://www.unix.com/shell-programming-scripting/18855-vt100-terminal-colour.html#post302078324
# http://networking.ringofsaturn.com/Unix/Bash-prompts.php
# http://www.debian-administration.org/article/Fancy_Bash_Prompts/print
#
# Details on tput:
# http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x405.html

# Attributes
TEXT_RESET="$(tput sgr0)"
TEXT_BOLD="$(tput bold)"  # AKA Bright
TEXT_DIM="$(tput dim)"  # Seems to be default
TEXT_UNDERSCORE="$(tput smul)"
TEXT_UNDERSCORE_END="$(tput rmul)"
TEXT_BLINK="$(tput blink)" # Doesn't seem to work
TEXT_REVERSE="$(tput rev)"

# Seems to be 8 or -1, the latter meaning only B&W are supported
NUM_COLORS=$(tput colors)

# Color codes for tput
TPUT_BLACK=0
TPUT_RED=1
TPUT_GREEN=2
TPUT_YELLOW=3
TPUT_BLUE=4
TPUT_MAGENTA=5
TPUT_CYAN=6
TPUT_WHITE=7

# Foreground colors
#
# Note 'setaf' vs 'setf' - I'm not entirely sure of the difference
# but one gets different colors.
FG_BLACK="$(tput setaf ${TPUT_BLACK})"
FG_RED="$(tput setaf ${TPUT_RED})"
FG_GREEN="$(tput setaf ${TPUT_GREEN})"
FG_BROWN="$(tput setaf ${TPUT_YELLOW})"  # AKA Yellow
FG_YELLOW="$(tput setaf ${TPUT_YELLOW})"
FG_BLUE="$(tput setaf ${TPUT_BLUE})"
FG_PURPLE="$(tput setaf ${TPUT_MAGENTA})"  # AKA Magenta
FG_MAGENTA="$(tput setaf ${TPUT_MAGENTA})"
FG_CYAN="$(tput setaf ${TPUT_CYAN})"
FG_WHITE="$(tput setaf ${TPUT_WHITE})"
FG_GRAY=${TEXT_BOLD}${FG_BLACK}

# Background colors
BG_BLACK="$(tput setab ${TPUT_BLACK})"
BG_RED="$(tput setab ${TPUT_RED})"
BG_GREEN="$(tput setab ${TPUT_GREEN})"
BG_BROWN="$(tput setab ${TPUT_YELLOW})"  # AKA Yellow
BG_YELLOW="$(tput setab ${TPUT_YELLOW})"
BG_BLUE="$(tput setab ${TPUT_BLUE})"
BG_PURPLE="$(tput setab ${TPUT_MAGENTA})"  # AKA Magenta
BG_MAGENTA="$(tput setab ${TPUT_MAGENTA})"
BG_CYAN="$(tput setab ${TPUT_CYAN})"
BG_WHITE="$(tput setab ${TPUT_WHITE})"

function test_escape_codes()
{
    local fgs="$FG_BLACK $FG_RED $RG_GREEN $FG_YELLOW \
	$FG_BLUE $FG_MAGENTA $FG_CYAN $FG_WHITE"
    local bgs="$BG_BLACK $BG_RED $RG_GREEN $BG_YELLOW \
	    $BG_BLUE $BG_MAGENTA $BG_CYAN $BG_WHITE"
    for fg in $fgs ; do
	echo -n ${fg}
	for bg in $bgs ; do
	    echo -n "${bg}Hello "
	done
	echo ${TEXT_RESET}
    done
    local colors="${FG_BLACK}Black ${FG_RED}Red ${FG_GREEN}Green ${FG_YELLOW}Yellow ${FG_BLUE}Blue ${FG_MAGENTA}Magenta ${FG_CYAN}Cyan ${FG_WHITE}White"

    echo ""
    echo "Normal ${colors}"
    echo "${TEXT_BOLD}Bold ${colors}${TEXT_RESET} "
    echo "${TEXT_DIM}Dim ${colors}${TEXT_RESET} "
    echo "${TEXT_UNDERSCORE}Underscore ${colors}${TEXT_RESET} "
    echo "${TEXT_BLINK}Blink ${colors}${TEXT_RESET} "
    echo "${TEXT_REVERSE}Reverse ${colors}${TEXT_RESET} "
    echo ""
}


######################################################################
#
# Codes for setting tab and window title
# See bashrc.title for use
# Note we don't delineate non-printable here, because these don't go into PS1
case $TERM in
    screen)
	# screen - set title of screen itself
	SET_TAB_TITLE_START="\033k"
	SET_TAB_TITLE_END="\033\\"

	SET_WINDOW_TITLE_START=${SET_TAB_TITLE_START}
	SET_WINDOW_TITLE_END=${SET_TAB_TITLE_END}
	;;
    xterm|xterm-color)
	# Kudos: http://xanana.ucsc.edu/xtal/iterm_tab_customization.html
	SET_TAB_TITLE_START="\033]1; "
	SET_TAB_TITLE_END="\007"

	SET_WINDOW_TITLE_START="\033]2; "
	SET_WINDOW_TITLE_END="\007"
	;;
    dumb|ansi|linux|*)
        # Does not support setting window or tab title
        SET_TAB_TITLE_START=""
	SET_TAB_TITLE_END=""

	SET_WINDOW_TITLE_START=""
	SET_WINDOW_TITLE_END=""
	;;
esac
