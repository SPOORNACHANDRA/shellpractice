component=payment
source common.sh
rabbitmq_app_password=$1case
if [ -z "${rabbitmq_app_password}" ]; then
echo input rabbitmq password missing
exit
fi
func_python
