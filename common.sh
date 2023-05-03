app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


func_print_head(){

1echo -e "\e[35m>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<\e[0m"


}


func_schema_setup(){
if [ "$schema_setup" == "mongo" ]; then

  func_print_head "copy mongo.repo file"  
  
  cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

    func_print_head  "installing mongodb"  
  
  yum install mongodb-org-shell -y  
  func_print_head "creating mongodb schema"   
 
  mongo --host mongodb.tej07.online </app/schema/$component.js
  func_print_head "restarting $component service"  

   systemctl restart $component
fi

if [ "$schema_setup" == 'mysql' ]; then

  func_print_head "copying mysql repo file"
  cp ${script_path}/mysql.repo  /etc/yum.repos.d/mysql.repo

  func_print_head "Downloading mysql"
  yum install mysql -y

  func_print_head "Loading mysql schema"
  mysql -h mysql.tej07.online -uroot -p${mysql_password} < /app/schema/$component.sql


 fi



}

func_app_prereq(){

func_print_head "Creat Application User"
useradd ${app_user}

func_print_head "Removing the /app folder"
rm -rf /app

func_print_head "Creat Application Directory"
mkdir /app

func_print_head "Downloading Application content"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 

func_print_head "Redirecting Application Directory "
cd /app 

func_print_head "Extracting Application content"
unzip /tmp/${component}.zip
}




func_systemd_setup(){
func_print_head "copying ${component}.service file"
cp ${script_path}/${component}.service  /etc/systemd/system/${component}.service

func_print_head "Realoding the daemon"
systemctl daemon-reload 

func_print_head "Enabling the ${component} "
systemctl enable ${component}"

func_print_head "restarting ${component}"
systemctl restart ${component}
}
 



func_nodejs(){
  func_print_head   "creating nodejs repo file"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "installing nodejs" 
yum install nodejs -y

 func_app_prereq

 func_print_head "installing nodejs dependencies" 
npm install

func_print_head "systemd_setup"
func_systemd_setup

func_print_head "schema_setup"
func_schema_setup
}



func_java(){

func_print_head "Installing maven"
yum install maven -y

func_app_prereq

func_print_head  "Downloading the java dependencies"
cd /app 
mvn clean package 
mv target/${component}-1.0.jar ${component}.jar

func_schema_setup

func_systemd_setup
}