echo -e "\e[36m>>>>>>>>>>>>creating nodejs repo file<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[35m>>>>>>>>>>>> installing nodejs <<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>> creating roboshop user <<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> creating application folder <<<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> downloading app content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 
echo -e "\e[35m>>>>>>>>>>>> unziping the app content <<<<<<<<<<<\e[0m"
unzip /tmp/user.zip
echo -e "\e[35m>>>>>>>>>>>> installing nodejs dependencies <<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>>>>>>>> copying service file <<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/user.service  /etc/systemd/system/user.service
echo -e "\e[35m>>>>>>>>>>>> realoading daemon <<<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[35m>>>>>>>>>>>> enable user  <<<<<<<<<<<\e[0m"
systemctl enable user
systemctl start user
echo -e "\e[35m>>>>>>>>>>>>copy mongo.repo file <<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>> installing mongodb  <<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>> creating mongodb schema <<<<<<<<<<<\e[0m"
mongo --host mongodb.tej07.online </app/schema/user.js
systemctl restart user

