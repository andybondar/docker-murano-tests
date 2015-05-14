#!/bin/bash -x

fails=`grep FAIL logs/* | wc -l`
errors=`grep ERROR logs/* | wc -l`

sum=$(($fails + $errors))

if [ "$sum" -gt 0 ]; then
    echo "There are $fails fails and $errors errors..."
    exit 1
fi

if [ "$sum" -eq 0 ]; then
    echo "All tests passed" > logs/results.log
fi
