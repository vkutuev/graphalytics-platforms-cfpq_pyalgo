#!/bin/bash
#
# Copyright 2015 Delft University of Technology
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Ensure the configuration file exists
rootdir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))/../..
config="${rootdir}/config"
if [ ! -f "$config/platform.properties" ]; then
	echo "Missing mandatory configuration file: $config/platform.properties" >&2
	exit 1
fi

# Construct the classpath
PLATFORM_HOME=$(grep -E "^platform.cfpq_pyalgo.home[	 ]*[:=]" $config/platform.properties | sed 's/platform.cfpq_pyalgo.home[\t ]*[:=][\t ]*\([^\t ]*\).*/\1/g' | head -n 1)
if [ -z $PLATFORM_HOME ]; then
    echo "Error: CFPQ_PyAlgo home directory not specified."
    echo "Define variable platform.cfpq_pyalgo.home in $config/platform.properties"
    exit 1
fi

# TODO Build binaries
# mkdir -p $rootdir/bin/exe
# (cd $rootdir/bin/exe && cmake -DCMAKE_BUILD_TYPE=Release ../../src/main/c -DPLATFORM_HOME=$PLATFORM_HOME && make all VERBOSE=1)

if [ $? -ne 0 ]
then
    echo "Compilation failed"
    exit 1
fi
