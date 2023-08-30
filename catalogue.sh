echo -e "\e[32m >>>>>>>> create catalogue service <<<<<<<<<\e[0m]"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> create mongodb repo <<<<<<<<<\e[0m]"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> install nodejs repos <<<<<<<<<\e[0m]"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> install nodejs <<<<<<<<<\e[0m]"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> create app user <<<<<<<<<\e[0m]"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
rm -rf /app &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> download app content <<<<<<<<<\e[0m]"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> extraction app content <<<<<<<<<\e[0m]"
cd /app &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> download dependences <<<<<<<<<\e[0m]"
npm install &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> install mongodb client <<<<<<<<<\e[0m]"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> load schema <<<<<<<<<\e[0m]"
mongo --host mongodbp.poornadevops.online </app/schema/catalogue.js &>>/tmp/roboshop.log
echo -e "\e[32m >>>>>>>> create catalogue service <<<<<<<<<\e[0m]"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

