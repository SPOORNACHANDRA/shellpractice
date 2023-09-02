source common.sh
echo -e "\e[32m >>>>>>>> install nginx <<<<<<<<<\e[0m]"
yum install nginx -y
func_exit_status
echo -e "\e[32m >>>>>>>> roboshop configuration <<<<<<<<<\e[0m]"
cp nginix-roboshop.conf /etc/nginx/default.d/roboshop.conf
func_exit_status
echo -e "\e[32m >>>>>>>> clean old content <<<<<<<<<\e[0m]"
rm -rf /usr/share/nginx/html/*
func_exit_status
echo -e "\e[32m >>>>>>>> install downlaod app content <<<<<<<<<\e[0m]"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
func_exit_status
cd /usr/share/nginx/html
echo -e "\e[32m >>>>>>>> extract application content <<<<<<<<<\e[0m]"
unzip /tmp/frontend.zip
func_exit_status
echo -e "\e[32m >>>>>>>> start nginx service <<<<<<<<<\e[0m]"
systemctl enable nginx
systemctl restart nginx
func_exit_status


