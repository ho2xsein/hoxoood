#!/usr/bin/env bash

install() {
echo -e "\e[1;36m   *Installing Bot: 1.Updating packages\e[0m"
sudo apt-get update
sudo apt-get upgrade

echo -e "\e[1;36m   *Installing Bot: 2.Installing dependencies\e[0m"
sudo apt-get install libreadline-dev libssl-dev lua5.2 luarocks liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev -y

echo -e "\e[1;36m   *Installing Bot: 3.Installing LuaRocks from sources\e[0m"

git clone http://github.com/keplerproject/luarocks
cd luarocks
./configure --lua-version=5.2
make build
sudo make install
cd ..

echo -e "\e[1;36m   *Installing Bot: 4.Installing rocks\e[0m"

rocks="luasocket luasec redis-lua lua-term serpent dkjson Lua-cURL"
for rock in $rocks; do
    sudo luarocks install $rock
done
chmod +x api.sh
sed -i 's/\r$//' api.sh

echo -e "\033[01;32m    Installing Done! [==============] 100%\033[0m\n \033[01;34m Now you Can run your bot! \033[0m"
echo "    >> Launch in Normal Mode : ./api.sh"
echo "    >> Launch in Screen Mode : screen ./api.sh"
echo " "
}
if [ "$1" = "install" ]; then
  install
else
  while [[ true ]]; do
    lua ./api/api.lua
  done
fi
