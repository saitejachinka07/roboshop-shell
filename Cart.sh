script_path=$(dirname $0)
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>>>>>creating nodejs repo file<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>> installing nodejs <<<<<<<<<<<\e[0m"

yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>> creating roboshop user <<<<<<<<<<<\e[0m"

useradd ${app_user}
echo -e "\e[35m>>>>>>>>>>>> removing roboshop user <<<<<<<<<<<\e[0m"

rm -rf /app

echo -e "\e[35m>>>>>>>>>>>> creating /app directory <<<<<<<<<<<\e[0m"

mkdir /app
echo -e "\e[35m>>>>>>>>>>>> downloading app content <<<<<<<<<<<\e[0m"

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 
echo -e "\e[35m>>>>>>>>>>>> unzipping app content <<<<<<<<<<<\e[0m"

unzip /tmp/cart.zip
echo -e "\e[35m>>>>>>>>>>>> downloading nodjs dependencies <<<<<<<<<<<\e[0m"

npm install

echo -e "\e[35m>>>>>>>>>>>> copying cart service  <<<<<<<<<<<\e[0m"

cp ${script_path}/Cart.service  /etc/systemd/system/cart.service

echo -e "\e[35m>>>>>>>>>>>> reloading daemon <<<<<<<<<<<\e[0m"

systemctl daemon-reload

echo -e "\e[35m>>>>>>>>>>>> enable cart <<<<<<<<<<<\e[0m"

systemctl enable cart
echo -e "\e[35m>>>>>>>>>>>> restarting cart <<<<<<<<<<<\e[0m"

systemctl restart cart
