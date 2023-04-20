yum install nginx -y
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
curl -o /tmp/chinka.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html
unzip /tmp/chinka.zip
systemctl restart nginx
systemctl enable nginx
