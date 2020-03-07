curl -fsSL https://get.docker.com | sh
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null
sudo apt-get update > /dev/null
sudo apt-get -yqq install code > /dev/null
