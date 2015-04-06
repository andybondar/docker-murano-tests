
def test_deploy_old_school(c):
    return {
	'hdp': 'test_deploy_hdp',
	'apache_mysql_wordpress': 'test_deploy_apache_http_mysql_wordpress',
	'postgres': 'test_deploy_postgres',
	'tomcat': 'test_deploy_apache_tomcat',
	'zabbix': 'test_deploy_zabbix_server',
	'standalone_docker': 'test_deploy_standalone_docker',
    }.get(c, 'test_deploy_tomcat')


import sys

x = sys.argv[1] if len(sys.argv) > 1 else 'tomcat'
print test_deploy_old_school(x)
