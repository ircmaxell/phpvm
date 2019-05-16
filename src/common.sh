#!/usr/bin/env bash

declare -A versions
source "$INSTALL_DIR/etc/config.map"

findconfig() {
	_dir=$1
	if [ "$_dir" == "/" ]; then
	    result=""
	else 
	    if [ -f "$_dir/.php-version" ]; then
	        result="$_dir/.php-version"
	    else 
	        ancestor "$_dir"
	        findconfig "$result"
	    fi
	fi
}


ancestor() {
	result="$(readlink -f -- "$1/..")"
}

if [ ! -z "$PHP_OVERRIDE" ]; then
	_PHP_BIN_PATH="${versions[${PHP_OVERRIDE}]}"
else

	findconfig "$(pwd)"

	if [ -z "$result" ]; then
    	# Use the default version
    	version="$default_version"
	else 
    	# read from the file, and trim the result using xargs
		version="$(cat $result | xargs)"
	fi

	if [[ -z "${versions[${version}]}" ]]; then
    	echo "Could not find installed PHP version $version"
    	exit 255
	fi

	PHP_OVERRIDE="${version}"

	_PHP_BIN_PATH="${versions[${version}]}"
fi