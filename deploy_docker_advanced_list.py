
def test_deploy_docker_advanced(c):
    return {
	'crate_nginxsite_glassfish': 'test_deploy_docker_crate_nginxsite_glassfish',
	'crate_nginx_mongodb': 'test_deploy_docker_crate_nginx_mongodb',
	'mariadb_postgresql_mongodb': 'test_deploy_docker_mariadb_postgresql_mongodb',
	'jenkins_httpd_phpzendserver': 'test_deploy_docker_jenkins_httpd_phpzendserver',
	'redis_tomcat_influxdb': 'test_deploy_docker_redis_tomcat_influxdb',
	'mysql_nginxsite_redis': 'test_deploy_docker_mysql_nginxsite_redis',
	'nginx_wait_deploy_httpd': 'test_deploy_docker_nginx_wait_deploy_httpd',
	'mysql_wait_deploy_tomcat': 'test_deploy_docker_mysql_wait_deploy_tomcat',
	'nginxsite_wait_deploy_phpzendserver': 'test_deploy_docker_nginxsite_wait_deploy_phpzendserver',
	'tomcat_wait_deploy_mariadb': 'test_deploy_docker_tomcat_wait_deploy_mariadb',
	'glassfish_wait_deploy_jenkins': 'test_deploy_docker_glassfish_wait_deploy_jenkins',
	'nginx_wait_deploy_crate': 'test_deploy_docker_nginx_wait_deploy_crate',
	'postgresql_wait_deploy_influxdb': 'test_deploy_docker_postgresql_wait_deploy_influxdb',
	'mongodb_wait_deploy_nginx': 'test_deploy_docker_mongodb_wait_deploy_nginx',
    }.get(c, 'test_deploy_docker_crate_nginxsite_glassfish')


import sys

x = sys.argv[1] if len(sys.argv) > 1 else 'tomcat'
print test_deploy_docker_advanced(x)


# crate_nginxsite_glassfish,crate_nginx_mongodb,mariadb_postgresql_mongodb,jenkins_httpd_phpzendserver,redis_tomcat_influxdb,mysql_nginxsite_redis,nginx_wait_deploy_httpd,mysql_wait_deploy_tomcat,nginxsite_wait_deploy_phpzendserver,tomcat_wait_deploy_mariadb,glassfish_wait_deploy_jenkins,nginx_wait_deploy_crate,postgresql_wait_deploy_influxdb,mongodb_wait_deploy_nginx
