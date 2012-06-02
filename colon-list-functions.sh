#!/bin/bash
#
# Functions for manipulation colon- and semicolon-separated lists
#

######################################################################
#
# Base functions used by colon and semicolon versions

function _colon_list_error
{
    echo $* 1>&2
    exit 1
}

function _list_to_lines  # list delim
{
    echo -e ${1//$2/\\n}
}

function _list_from_lines # delim, lines read from stdin
{
    local delim=${1}; shift
    local list element
    while read element ; do
	list=${list}${list:+$delim}${element}
    done
    echo $list
}

# Returns 0 if element is in list, 1 otherwise
function _list_contains # list, delim, element
{
    # 'grep -x' matches whole lines only
    _list_to_lines ${1} ${2} | grep -x ${3} > /dev/null
}

function _list_remove # list, delim, elements...
{
    local list=$1; shift
    local delim=$1; shift
    local element
    for element ; do
	list=$(_list_to_lines $list $delim | \
	    grep -v -x $element | \
	    _list_from_lines $delim)
    done
    echo $list
}

function _list_append # list, delim, elements...
{
    local list=$1; shift
    local delim=$1; shift
    local element
    for element ; do
	list=$(_list_remove $list $delim $element)
	# This handles list now being empty
	list=${list}${list:+$delim}${element}
    done
    echo $list
}

function _list_prepend # list, delim, elements...
{
    local list=$1; shift
    local delim=$1; shift
    local element
    for element ; do
	list=$(_list_remove $list $delim $element)
	# This handles list now being empty
	list=${element}${list:+$delim}${list}
    done
    echo $list
}


######################################################################
#
# Colon versions
#

function colon_list_to_lines
{
    local usage="colon_list_to_lines <list>"
    test $# -eq 1 || _colon_list_error $usage
    _list_to_lines ${1} ":"
}

function colon_list_from_lines
{
    local usage="colon_list_form_lines"
    test $# -eq 0 || _colon_list_error $usage
    _list_from_lines ":"
}

# Returns 0 if element is in list, 1 otherwise
function colon_list_contains
{
    local usage="colon_list_contains <list> <element>"
    test $# -eq 2 || _colon_list_error $usage
    _list_contains ${1} ":" ${2}
}

function colon_list_remove
{
    local usage="colon_list_remove <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_remove "$list" ":" "$@"
}

function colon_list_append
{
    local usage="colon_list_append <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_append $list ":" "$@"
}

function colon_list_prepend
{
    local usage="colon_list_prepend <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_prepend $list ":" "$@"
}

######################################################################
#
# Semicolon versions


function semicolon_list_to_lines
{
    local usage="colon_list_to_lines <list>"
    test $# -eq 1 || _colon_list_error $usage
    _list_to_lines ${1} ";"
}

function semicolon_list_from_lines
{
    local usage="colon_list_form_lines"
    test $# -eq 0 || _colon_list_error $usage
    _list_from_lines ";"
}

# Returns 0 if element is in list, 1 otherwise
function semicolon_list_contains
{
    local usage="colon_list_contains <list> <element>"
    test $# -eq 2 || _colon_list_error $usage
    _list_contains ${1} ";" ${2}
}

function semicolon_list_remove
{
    local usage="colon_list_remove <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_remove "$list" ";" "$@"
}

function semicolon_list_append
{
    local usage="colon_list_append <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_append $list ";" "$@"
}

function semicolon_list_prepend
{
    local usage="colon_list_prepend <list> <elements...>"
    test $# -ge 1 || _colon_list_error $usage
    local list=$1; shift
    _list_prepend $list ";" "$@"
}

