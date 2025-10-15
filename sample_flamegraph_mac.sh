pid=$1
duration=$2
timestamp=$(date +%s)
interval_ms=1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
data_dir=$SCRIPT_DIR/results_mac/$timestamp

mkdir -p $data_dir

sample $pid -f $data_dir/samples.prof $duration $interval_ms 
filtercalltree $data_dir/samples.prof > $data_dir/samples_filtered.prof
$SCRIPT_DIR/FlameGraph/stackcollapse-sample.awk $data_dir/samples_filtered.prof > $data_dir/calls.folded
$SCRIPT_DIR/FlameGraph/flamegraph.pl $data_dir/calls.folded > $data_dir/flamegraph.svg

echo Result: $data_dir/flamegraph.svg

