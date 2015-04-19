#!/bin/bash -x

if [ -z "$deploy_old_school_test_list" ]; then
    echo "Test list is EMPTY!"
    exit 1
fi

#virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt
source .env/bin/activate

IFS=',' read -a array <<< "$deploy_old_school_test_list"


for i in "${array[@]}"
do
    app_test=`python deploy_old_school_list.py $i`
    nosetests -sv test_deploy_old_school.py:MuranoOldSchoolTest.$app_test &> logs/${app_test}.log
#    result=`head -1 logs/${app_test}.log | awk '{print $3}'`
    result=`tail -1 logs/${app_test}.log | awk '{print $1}'`
    tail -3 logs/${app_test}.log | head -1
#    if [ "$result" = "ok" ]; then
#	mv logs/${app_test}.log logs/${app_test}_OK.log
#    else
    mv logs/${app_test}.log logs/${app_test}_${result}.log
#    fi
done
