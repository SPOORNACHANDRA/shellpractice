func_nodejs() {
  cp ${component}.service /etc/systemd/system/${component}.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
cd /app
unzip /tmp/${component}.zip
cd /app
npm install

mongo --host mongodbp.poornadevops.online </app/schema/${component}.js
systemctl daemon-reload
systemctl enable ${component}
systemctl restart ${component}
}