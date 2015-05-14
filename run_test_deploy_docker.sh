#!/bin/bash -x

source .env/bin/activate
nosetests -sv test_deploy_docker.py &> logs/test_deploy_docker.log
