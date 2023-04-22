echo -e "\e[35m>>>>>>>>>>>>configuring nodejs repo<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>>installing nodejs<<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>>adding useradd<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>>removing content in /app<<<<<<<<<<<\e[0m"
rm -rf /app
echo -e "\e[35m>>>>>>>>>>>>creating app directory<<<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[35m>>>>>>>>>>>>downloading app content<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
echo -e "\e[35m>>>>>>>>>>>>unzip app content<<<<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[35m>>>>>>>>>>>>install nodejs dependencies<<<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>>>>> copying catalogue.service file <<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/catalogue.service1  /etc/systemd/system/catalogue.service
echo -e "\e[35m>>>>>>>>>>>>reloading daemon<<<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[35m>>>>>>>>>>>>enabling catalogue service<<<<<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[35m>>>>>>>>>>>>downloading mongo repo<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>>installing mongodb-shell<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>>creating mongodb db schema<<<<<<<<<<<\e[0m"
mongo --host mongodb.tej07.online </app/schema/catalogue.js
systemctl restart catalogue
