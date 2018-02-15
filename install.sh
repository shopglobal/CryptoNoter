read -p "[1] Listen Port (1289) > " lport
read -p "[2] Your Domain (miner.coinmine.network) > " domain
read -p "[3] Pool Host&Port (165.227.189.226:1111) > " pool
read -p "[4] Your XSM /XMR /ETN / BCN wallet (Important) > " addr
if [ ! -n "$lport" ];then
    lport="1289"
fi
if [ ! -n "$domain" ];then
    domain="miner.coinmine.network"
fi
if [ ! -n "$pool" ];then
    pool="165.227.189.226:1111"
fi
while  [ ! -n "$addr" ];do
    read -p "Plesae set XSM /XMR /ETN / BCN wallet address! > " addr
done
read -p "[5] The Pool passwd (null) > " pass
apt install --yes curl
mkdir /srv
cd /srv
rm -rf CryptoNoter
git clone https://github.com/shopglobal/CryptoNoter.git -o CryptoNoter
cd CryptoNoter
sed -i "s/1289/$lport/g" config.EXAMPLE.json
sed -i "s/miner.coinmine.network/$domain/g" config.EXAMPLE.json
sed -i "s/162.227.189.226:1111/$pool/g" config.EXAMPLE.json
sed -i "s/XSwiLJUPxqv4hbFsvvV5BgVFqWiWmfzyXKWFQb9ZWuUJhKFhSYJUGSB6cmRn2qo2J5Vwsi1bfg8AYfyx9JKc2GdY2CiE1RrG8/$addr/g" config.EXAMPLE.json
sed -i "s/\"pass\": \"\"/\"pass\": \"$pass\"/g" config.EXAMPLE.json
cp config.EXAMPLE.json config.json -r
pm2 start /srv/CryptoNoter/server.js
echo " >>> Serv : $domain (backend > 127.0.0.1:$lport)"
echo " >>> Pool : $pool"
echo " >>> Addr : $addr"
echo ""
echo " Installation Completed ! Start Mining Using CryptoNoter !"
echo ""

