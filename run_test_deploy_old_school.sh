#!/bin/bash -x

if [ -z "$deploy_old_school_test_list" ]; then
    echo "Test list is EMPTY!"
    exit 1
fi

#virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt

IFS=',' read -a array <<< "$deploy_old_school_test_list"


for i in "${array[@]}"
do
    app_test=`python deploy_old_school_list.py $i`
    nosetests -sv test_deploy_old_school.py:MuranoOldSchoolTest.$app_test &> logs/${app_test}.log
    result=`cat logs/${app_test}.log | head -1 | awk '{print $3}'`
    if [ "$result" = "ok" ]; then
	mv logs/${app_test}.log logs/${app_test}_OK.log
    else
	mv logs/${app_test}.log logs/${app_test}_${result}.log
    fi
done
