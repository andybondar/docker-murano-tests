#!/bin/bash -x

source .env/bin/activate
nosetests -sv test_deploy_docker_advanced.py &> logs/test_deploy_docker_advanced.log
