script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>> disable default mysql version <<<<<<<<<<\e[0m"
dnf module disable mysql -y 
echo -e "\e[36m>>>>>>>>> copying mysql repo <<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mysql.repo  /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>>> installing mysql <<<<<<<<<<\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m>>>>>>>>> enabling mysql service <<<<<<<<<<\e[0m"
systemctl enable mysqld
echo -e "\e[36m>>>>>>>>> start mysql service <<<<<<<<<<\e[0m"
systemctl start mysqld
echo -e "\e[36m>>>>>>>>> Reset Mysql password <<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
#mysql -uroot -pRoboShop@1
