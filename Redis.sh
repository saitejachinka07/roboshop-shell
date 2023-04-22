yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
yum install redis -y
echo -e "\e[35m>>>>>>edit REDIS.CONF<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
echo -e "\e[35m>>>>>>edit REDIS.2.CONF<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf
systemctl enable redis 
systemctl restart redis 