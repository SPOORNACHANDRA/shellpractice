log=/tmp/roboshop.log

echo -e "\e[32m >>>>>>>> create catalogue service <<<<<<<<<\e[0m]"
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}
echo -e "\e[32m >>>>>>>> create mongodb repo <<<<<<<<<\e[0m]"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
echo -e "\e[32m >>>>>>>> install nodejs repos <<<<<<<<<\e[0m]"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo -e "\e[32m >>>>>>>> install nodejs <<<<<<<<<\e[0m]"
yum install nodejs -y &>>${log}
echo -e "\e[32m >>>>>>>> create app user <<<<<<<<<\e[0m]"
useradd roboshop &>>${log}
echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
rm -rf /app &>>${log}
echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
mkdir /app &>>${log}
echo -e "\e[32m >>>>>>>> download app content <<<<<<<<<\e[0m]"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
echo -e "\e[32m >>>>>>>> extraction app content <<<<<<<<<\e[0m]"
cd /app &>>${log}
unzip /tmp/catalogue.zip &>>${log}
echo -e "\e[32m >>>>>>>> download dependences <<<<<<<<<\e[0m]"
npm install &>>${log}
echo -e "\e[32m >>>>>>>> install mongodb client <<<<<<<<<\e[0m]"
yum install mongodb-org-shell -y &>>${log}
echo -e "\e[32m >>>>>>>> load schema <<<<<<<<<\e[0m]"
mongo --host mongodbp.poornadevops.online </app/schema/catalogue.js &>>${log}
echo -e "\e[32m >>>>>>>> create catalogue service <<<<<<<<<\e[0m]"
systemctl daemon-reload &>>${log}
systemctl enable catalogue &>>${log}
systemctl start catalogue &>>${log}

