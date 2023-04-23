echo -e "\e[36m>>>>>>> Installing Maven <<<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>> Adding Roboshop user <<<<<<<<<<<\e[0m"

useradd roboshop

echo -e "\e[36m>>>>>>> Removing /app directory <<<<<<<<<<<\e[0m"

rm -rf /app

echo -e "\e[36m>>>>>>> Creating /app directory <<<<<<<<<<<\e[0m"

mkdir /app

echo -e "\e[36m>>>>>>> Downloading app content <<<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 

echo -e "\e[36m>>>>>>> Unzipping the app content <<<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
cd /app 

echo -e "\e[36m>>>>>>> Installing Maven Package <<<<<<<<<<<\e[0m"
mvn clean package 

mv target/shipping-1.0.jar shipping.jar 



echo -e "\e[36m>>>>>>>>>>>> installing mysql <<<<<<<<<<<<"

yum install mysql -y 

echo -e "\e[36m>>>>>>>>>>>> Load mysql schema <<<<<<<<<<<<"

mysql -h mysql.tej07.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 

echo -e "\e[36m>>>>>>>>>>>> Copying shipping service <<<<<<<<<<<<"

cp /home/centos/roboshop-shell/shipping.service  /etc/systemd/system/shipping.service


echo -e "\e[36m>>>>>>>>>>>> starting shipping service <<<<<<<<<<<<"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
