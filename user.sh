cp user.service /etc/systemd/system/user.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
cd /app
npm install
yum install mongodb-org-shell -y
mongo --host mongodbp.poornadevops.online </app/schema/user.js
systemctl daemon-reload
systemctl enable user
systemctl start user
