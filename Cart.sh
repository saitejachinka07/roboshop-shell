script_path=$(dirname $0)
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>>>>>creating nodejs repo file<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>> installing nodejs <<<<<<<<<<<\e[0m"

component=cart

func_nodejs