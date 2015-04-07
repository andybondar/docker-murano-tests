#!/bin/bash -x

if [ -z "$deploy_docker_test_list" ]; then
    echo "Test list is EMPTY!"
    exit 1
fi

virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt

IFS=',' read -a array <<< "$deploy_docker_test_list"


for i in "${array[@]}"
do
    app_test=`python deploy_docker_list.py $i`
    nosetests -sv test_deploy_docker.py:MuranoDockerTest.$app_test &> logs/${app_test}.log
done
