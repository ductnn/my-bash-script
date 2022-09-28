######## MONO Packages ########

# Install common packages
sudo apt install zip make -y
sudo apt-get install pcscd -y
sudo service pcscd start

# Docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo usermod -aG docker $USER
sudo apt install docker-compose -y

# Nginx
sudo apt install nginx -y

# AWS
sudo apt install awscli -y

# Mysql, Redis template
mkdir docker
cd docker
mkdir mysql redis
cd mysql
curl https://raw.githubusercontent.com/ductnn/my-bash-script/master/package/docker-compose-mysql.yml > docker-compose.yml
cd ..
cd redis
curl https://raw.githubusercontent.com/ductnn/my-bash-script/master/package/docker-compose-redis.yml > docker-compose.yml
