# Easy flamegraph generation

## Origin

Inspiration taken from:

https://stackoverflow.com/questions/23200704/install-perf-on-mac

# Requirements and setup

For running on Mac (these may already be installed/come with xcode developer tools!)
- `sample`
- `filtercalltree`
- `perl`

To setup:
1. run `git submodule init` to clone the Flamegraph submodule 


Other OS's are not supported (yet?).


## Set of commands combined:

Automated usage:

```
./sample_flamegraph_mac.sh <pid> <sampling duration seconds>
```

This will produce a flamegraph for process <pid> sampled over the indicated duration. The flamegraph location will be printed afterward.

On mac, the simplest way to open these is with `open <path to .svg>`.

Manual example that the script automates:
```
sample <pid> -f output.prof <duration seconds> <sample interval in millis> 
filtercalltree output.prof  > filtered.prof
./stackcollapse-sample.awk filtered.prof > out.folded
./FlameGraph/flamegraph.pl out.folded > flamegraph.svg
```


