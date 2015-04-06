#!/bin/bash -x

if [ -z "$deploy_old_school_test_list" ]; then
    echo "Test list is EMPTY!"
    exit 1
fi

virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt

IFS=',' read -a array <<< "$deploy_old_school_test_list"


for i in "${array[@]}"
do
    app_test=`python deploy_old_school_list.py $i`
    nosetests -sv --collect-only test_deploy_old_school.py:MuranoOldSchoolTest.$app_test
done
