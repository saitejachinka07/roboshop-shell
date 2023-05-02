app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


print_head(){

echo -e "\e[36m>>>>>>>>>>>>>>>> $1 <<<<<<<<<<<\e[0m"


}


schema_setup(){
if [ "$schema_setup" == "mongo" ]; then

  copy mongo.repo file  
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
  installing mongodb   
yum install mongodb-org-shell -y  
  creating mongodb schema   
mongo --host mongodb.tej07.online </app/schema/$component.js
systemctl restart $component
fi

}

 


func_nodejs() {
  print_head   "creating nodejs repo file"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print_head "installing nodejs" 
yum install nodejs -y
  print_head "creating roboshop user" 
useradd ${app_user}
 print_head "removing /app folder" 
rm -rf /app
 print_head "creating application folder" 
mkdir /app
 print_head "downloading app content"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 
 print_head "unziping the app content" 
unzip /tmp/${component}.zip
 print_head "installing nodejs dependencies" 
npm install
 print_head "copying service file "
cp ${script_path}/${component}.service  /etc/systemd/system/${component}.service
 print_head "realoading daemon" 
systemctl daemon-reload
 print_head "enable user"  
systemctl enable ${component}
systemctl start ${component}

schema_setup
}