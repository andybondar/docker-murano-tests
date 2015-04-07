
def test_deploy_docker(c):
    return {
	'influx_grafana': 'test_deploy_docker_influx_grafana',
	'mongodb': 'test_deploy_docker_mongodb',
	'nginx': 'test_deploy_docker_nginx',
	'glassfish': 'test_deploy_docker_glassfish',
	'mariadb': 'test_deploy_docker_mariadb',
	'mysql': 'test_deploy_docker_mysql',
	'phpzendserver': 'test_deploy_docker_phpzendserver',
	'jenkins': 'test_deploy_docker_jenkins',
	'postgres': 'test_deploy_docker_postgres',
	'crate': 'test_deploy_docker_crate',
	'redis': 'test_deploy_docker_redis',
	'tomcat': 'test_deploy_docker_tomcat',
	'httpd': 'test_deploy_docker_httpd',
	'nginx_site': 'test_deploy_docker_nginx_site',
	'container': 'test_deploy_docker_container',
    }.get(c, 'test_deploy_docker_tomcat')


import sys

x = sys.argv[1] if len(sys.argv) > 1 else 'tomcat'
print test_deploy_docker(x)

#influx_grafana,mongodb,nginx,glassfish,mariadb,mysql,phpzendserver,jenkins,postgres,crate,redis,tomcat,httpd,nginx_site,container