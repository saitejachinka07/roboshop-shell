echo -e "\e[36m>>>>>>> Installing Maven <<<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>> creating roboshop user <<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> deleting the directory /app <<<<<<<<<<<\e[0m"

rm -rf /app

echo -e "\e[36m>>>>>>> creating /app directory  <<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>> downloading app content <<<<<<<<<<<\e[0m"

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 
echo -e "\e[36m>>>>>>> unziping the app content <<<<<<<<<<<\e[0m"

unzip /tmp/shipping.zip

echo -e "\e[36m>>>>>>> installing nodejs dependencies <<<<<<<<<<<\e[0m"

cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

echo -e "\e[36m>>>>>>> copying shipping service file <<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/shipping.service  /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>> installing mysql <<<<<<<<<<<\e[0m"

yum install mysql -y 


echo -e "\e[36m>>>>>>> removing mysql passwd <<<<<<<<<<<\e[0m"

mysql -h mysql.tej07.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 

echo -e "\e[36m>>>>>>> start shipping service <<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
