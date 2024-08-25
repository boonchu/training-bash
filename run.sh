#!/usr/bin/env bash

# https://www.youtube.com/watch?v=eF6qpdIY7Ko
# https://gist.github.com/vncsna/64825d5609c146e80de8b1fd623011ca
set -euo pipefail

f() {
	pushd /tmp >& /dev/null
	echo hello from "$(pwd)"
	popd >& /dev/null
}

f
