#!/bin/bash
#
# Functions for setting path

include colon-list-functions.sh

function in_path()
{
    # Return 0 if given directory is already in PATH, 1 otherwise
    colon_list_contains $PATH $1
}

function path_append()
{
    PATH=$(colon_list_append $PATH $@)
}

function path_prepend()
{
    PATH=$(colon_list_prepend $PATH $@)
}

function path_remove()
{
    # Remove given directories from PATH
    PATH=$(colon_list_remove $PATH $@)
}

