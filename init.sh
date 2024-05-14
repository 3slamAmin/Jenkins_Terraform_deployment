#!/bin/bash
sudo yum install -y wget
sudo yum install -y nodejs
sudo npm install pm2@latest -g
sudo pm2 startup
cd ~/
sudo touch test.txt
wget https://github.com/3slamAmin/Github-CICD/releases/latest/download/dist.tar.gz
sudo tar xf dist.tar.gz
cd ~/dist/
npm install 
sudo PORT=80 pm2 start "node main.js"