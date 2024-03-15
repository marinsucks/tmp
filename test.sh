shuf -i 1-$1 -n $1 | tr '\n' ' ' > $1
arg=$(cat $1); ./push_swap $arg | ./checker $arg
