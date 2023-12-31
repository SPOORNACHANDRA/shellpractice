${mysql_root_password}=$1
if [ -z "${mysql_root_password}" ]; then
echo input mysql password missing
exit
fi

cp mysql.repo /etc/yum.repos.d/mysql.repo
yum module disable mysql -y
yum install mysql-community-server -y
mysql_secure_installation --set-root-pass ${mysql_root_password}
systemctl enable mysqld
systemctl restart mysqld