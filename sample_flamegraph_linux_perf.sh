#!/bin/bash

pid=$1
duration=$2
timestamp=$(date +%s)
interval_ms=1
sampling_rate=$((1000 / interval_ms))


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
data_dir=$SCRIPT_DIR/results_linux_perf/$timestamp

mkdir -p $data_dir

perf record -F $sampling_rate -p $pid -g -a -- sleep $duration
perf script > $data_dir/samples.perf

$SCRIPT_DIR/FlameGraph/stackcollapse-perf.pl $data_dir/samples.perf > $data_dir/samples.folded
$SCRIPT_DIR/FlameGraph/flamegraph.pl $data_dir/samples.folded > $data_dir/flamegraph.svg

echo Result: $data_dir/flamegraph.svg

