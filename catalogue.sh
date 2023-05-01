script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue
func_nodejs
echo -e "\e[35m>>>>>>>>>>>>downloading mongo repo<<<<<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>>installing mongodb-shell<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>>creating mongodb db schema<<<<<<<<<<<\e[0m"
mongo --host mongodb.tej07.online </app/schema/catalogue.js
systemctl restart catalogue
