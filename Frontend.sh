script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>>>> Installing nginx<<<<<<<<<\e[0m"
yum install nginx -y
echo -e "\e[36m>>>>>>>>>>>>>> copying robohsop.conf to etc<<<<<<<<<<<<<"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>>> Removing the initial content in nginx server<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36m>>>>>>>>>>> Downloading the app content<<<<<<<<<<\e[0m"
curl -o /tmp/chinka.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html
echo -e "\e[36m>>>>>>>>>>> unzipuing the app content <<<<<<<<<<<\e[0m"
unzip /tmp/chinka.zip
echo -e "\e[36m>>>>>>>>>>> restarting nginx  <<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx
