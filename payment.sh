echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Installing python   <<<<<<<<<<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   creatig roboshop user   <<<<<<<<<<<<<<<<<<\e[0m"

useradd roboshop
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   removing /app   <<<<<<<<<<<<<<<<<<\e[0m"


rm -rf /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>  creating /app   <<<<<<<<<<<<<<<<<<\e[0m"

mkdir /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Downloading app content   <<<<<<<<<<<<<<<<<<\e[0m"

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   unziping the app content   <<<<<<<<<<<<<<<<<<\e[0m"

unzip /tmp/payment.zip
cd /app 
echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Installing python dependencies   <<<<<<<<<<<<<<<<<<\e[0m"

pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   copying payment.service file   <<<<<<<<<<<<<<<<<<\e[0m"

cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Reloading daemon   <<<<<<<<<<<<<<<<<<\e[0m"

systemctl daemon-reload


echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Enabling payment   <<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable payment

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>   Restarting payment   <<<<<<<<<<<<<<<<<<\e[0m"

systemctl restart payment
