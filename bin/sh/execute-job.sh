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

rootdir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))/../..

# Parse commandline instructions (provided by Graphalytics).
while [[ $# -gt 1 ]] # Parse two arguments: [--key value] or [-k value]
  do
  key="$1"
  value="$2"

  case $key in

    --job-id)
      JOB_ID="$value"
      shift;;

    --log-path)
      LOG_PATH="$value"
      shift;;

    --algorithm)
      ALGORITHM="$value"
      shift;;

    --source-vertex)
      SOURCE_VERTEX="$value"
      shift;;

    --max-iteration)
      MAX_ITERATION="$value"
      shift;;

    --damping-factor)
      DAMPING_FACTOR="$value"
      shift;;

    --input-path)
      INPUT_PATH="$value"
      shift;;

    --output-path)
      OUTPUT_PATH="$value"
      shift;;

    --grammar-path)
          GRAMMAR_PATH="$value"
          shift;;

    --home-dir)
      HOME_DIR="$value"
      shift;;

    --num-machines)
      NUM_MACHINES="$value"
      shift;;

    --num-threads)
      NUM_THREADS="$value"
      shift;;

    *)
      echo "Error: invalid option: " "$key"
      exit 1
      ;;
  esac
  shift
done

# Construct executable commandline instructions (platform-specific).
 case $ALGORITHM in

     apr)
       COMMAND="python3 $rootdir/src/main/python/src/algorithms/$ALGORITHM.py --jobid $JOB_ID \
         --grammar $GRAMMAR_PATH \
         --dataset $INPUT_PATH --output $OUTPUT_PATH"

       ;;


     *)
       echo "Error: algorithm " + $ALGORITHM +"not defined."
       exit 1
       ;;
 esac



echo "Executing platform job" "$COMMAND"

$COMMAND &
echo $! > $LOG_PATH/executable.pid
wait $!
