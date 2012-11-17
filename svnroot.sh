# Usage: svnroot [<command>]
#
# With no command given, this function outputs the relative path to the top
# level of the current SVN checkout.
#
# With a command, the command is run in the top level of the current SVN
# checkout.
#
# If run when not in a SVN checkout, an error is printed to STDERR and it
# returns 1.
#
# Kudos: http://stackoverflow.com/a/1242377/197789
function svnroot
{
    local parent=""
    local grandparent="."

    while [ -d "$grandparent/.svn" ]; do
        parent=$grandparent
        grandparent="$parent/.."
    done

    if [ -z "$parent" ]; then
        echo "Not in SVN repository" 1>&2
        return 1
    fi

    if [ $# -eq 0 ]; then
        # No command given, just print root
        echo ${parent}
    else
        # CD to root in subshell and execute command
        ( cd ${parent} && "${@}" )
    fi
}

