component=payment
source common.sh
rabbitmq_app_password=$1
if [ -z "${rabbitmq_app_password}" ]; then
echo input rabbitmq password missing
exit
fi
func_python
