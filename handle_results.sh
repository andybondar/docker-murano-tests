#!/bin/bash -x

fails=`ls -lh logs/ | grep FAIL | wc -l`
errors=`ls -lh logs/ | grep ERROR | wc -l`

sum=$(($fails + $errors))

if [ "$sum" -gt 0 ]; then
    echo "There are $fails fails and $errors errors..."
    exit 1
fi

if [ "$sum" -gt 0 ]; then
    echo "All tests passed."
fi

tar cvfz report.tar.gz logs/*
rm -f logs/*
mv report.tar.gz logs/