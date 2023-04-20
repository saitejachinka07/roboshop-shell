yum install nginx -y
rm -rf /usr/share/nginx/html/*
curl -o /tmp/chinka.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html
unzip /tmp/chinka.zip


# some file nees to be created


systemctl restart nginx
systemctl enable nginx
