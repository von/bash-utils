# Returng last N components of $PWD
# Intended for short paths for window titles and the like
function trailing_pwd_components()
{
    # Return N trailing components from currenting working directory
    local i=${1:-2}  # N==2 by default
    
    local pwd=${PWD/~/\~}   # Replace $HOME with literal '~'
    local trailing=""

    for ((; i >0 ; i--)); do
	local base=$(basename "$pwd")
	pwd=$(dirname "$pwd")

	if test "X${trailing}" = "X" ; then
	    trailing=${base}
	else
	    trailing=${base}"/"${trailing}
	fi

	if test "${pwd}" = "." ; then
	    # Reached home directory. We're done
	    break
	fi
	if test "${pwd}" = "/" ; then
	    # Reached root directory. Added root indicator and
	    # we're done
	    trailing="/"${trailing}
	    break
	fi
    done
    echo $trailing
}
