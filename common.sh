log=/tmp/roboshop.log

func_apppreq() {
   echo -e "\e[32m >>>>>>>> create app ${component} <<<<<<<<<\e[0m]"
    add roboshop &>>${log}
    echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
    rm -rf /app &>>${log}
    echo -e "\e[32m >>>>>>>> create app directory <<<<<<<<<\e[0m]"
    mkdir /app &>>${log}
    echo -e "\e[32m >>>>>>>> download app content <<<<<<<<<\e[0m]"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
    echo -e "\e[32m >>>>>>>> extraction app content <<<<<<<<<\e[0m]"
    cd /app &>>${log}
}

func_systemd() {
  echo -e "\e[32m >>>>>>>> create ${component} service <<<<<<<<<\e[0m]"
  systemctl daemon-reload &>>${log}
  systemctl enable ${component} &>>${log}
  systemctl start ${component} &>>${log}
}

func_nodejs() {
  echo -e "\e[32m >>>>>>>> create ${component} service <<<<<<<<<\e[0m]"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}
  echo -e "\e[32m >>>>>>>> create mongodb repo <<<<<<<<<\e[0m]"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
  echo -e "\e[32m >>>>>>>> install nodejs repos <<<<<<<<<\e[0m]"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  echo -e "\e[32m >>>>>>>> install nodejs <<<<<<<<<\e[0m]"
  yum install nodejs -y &>>${log}
func_apppreq
  unzip /tmp/${component}.zip &>>${log}
  echo -e "\e[32m >>>>>>>> download dependences <<<<<<<<<\e[0m]"
  npm install &>>${log}
  echo -e "\e[32m >>>>>>>> install mongodb client <<<<<<<<<\e[0m]"
  yum install mongodb-org-shell -y &>>${log}
  echo -e "\e[32m >>>>>>>> load schema <<<<<<<<<\e[0m]"
  mongo --host mongodbp.poornadevops.online </app/schema/${component}.js &>>${log}
 func_systemd
}

func_java() {
  echo -e "\e[32m >>>>>>>> create ${component} service <<<<<<<<<\e[0m]"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}
  echo -e "\e[32m >>>>>>>> install maven <<<<<<<<<\e[0m]"
  yum install maven -y &>>${log}
func_apppreq
echo -e "\e[32m >>>>>>>> build ${component} <<<<<<<<<\e[0m]"
mvn clean package &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}
echo -e "\e[32m >>>>>>>> install mysql <<<<<<<<<\e[0m]"
yum install mysql -y &>>${log}
echo -e "\e[32m >>>>>>>> load schema <<<<<<<<<\e[0m]"
mysql --host mysqlp.poornadevops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
func_systemd
}