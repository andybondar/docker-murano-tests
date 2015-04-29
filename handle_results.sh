#!/bin/bash -x

fails=`ls -lh logs/ | grep FAIL | wc -l`
errors=`ls -lh logs/ | grep ERROR | wc -l`

sum=$(($fails + $errors))

rm -f logs/*_OK.log

if [ "$sum" -gt 0 ]; then
    echo "There are $fails fails and $errors errors..."
    exit 1
fi

if [ "$sum" -eq 0 ]; then
    echo "All tests passed" > logs/results.log
fi

