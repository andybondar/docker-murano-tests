#!/bin/bash -x

source .env/bin/activate
nosetests -sv test_deploy_old_school.py: &> logs/test_deploy_old_school.log
