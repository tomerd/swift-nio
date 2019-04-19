#!/bin/bash
##===----------------------------------------------------------------------===##
##
## This source file is part of the SwiftNIO open source project
##
## Copyright (c) 2017-2018 Apple Inc. and the SwiftNIO project authors
## Licensed under Apache License v2.0
##
## See LICENSE.txt for license information
## See CONTRIBUTORS.txt for the list of SwiftNIO project authors
##
## SPDX-License-Identifier: Apache-2.0
##
##===----------------------------------------------------------------------===##

set -e

here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function usage() {
    echo >&2 "$0 <version1> <version2>"
    echo >&2
    echo >&2 "Runs the swift-api-digester tool against the requested versions."
}

if ! test $# -eq 2; then
    usage
    exit 1
fi

version_1=$1
version_2=$2
branch_name=$(git rev-parse --abbrev-ref HEAD)

# FIXME: loop all modules
module=NIO

# build and dump version 1 info
git checkout -f $version_1
swift build
swift-api-digester -dump-sdk -module $module -o "$module-$version_1.json" -I .build/debug

# build and dump version 2 info
git checkout -f $version_2
swift build
swift-api-digester -dump-sdk -module $module -o "$module-$version_2.json" -I .build/debug

# run diagnosis
swift-api-digester -diagnose-sdk --input-paths "$module-$version_1.json" -input-paths "$module-$version_2.json"

# go back to original branch
git checkout -f $branch_name
