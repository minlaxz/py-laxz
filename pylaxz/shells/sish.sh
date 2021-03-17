# Make a house a home
echo "export PS1=\"\\[\\033[38;5;33m\\]\\u\\[\$(tput sgr0)\\]\\[\\033[38;5;11m\\]@\\[\$(tput sgr0)\\]\\[\\033[38;5;33m\\]\\H\\[\$(tput sgr0)\\]\\[\\033[38;5;15m\\]:\\[\$(tput sgr0)\\]\\[\\033[38;5;11m\\]\\w\\[\$(tput sgr0)\\]\\[\\033[38;5;15m\\]\\\\$ \\[\$(tput sgr0)\\]\"" >> ~/.bashrc
source ~/.bashrc
apt update
apt upgrade
apt install ack-grep mc byobu git curl locate
updatedb

# Security
ufw allow http
ufw allow https
ufw allow ssh
ufw allow 2222
ufw --force enable
apt install fail2ban

# Create swapfile
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Install Docker
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install docker-ce docker-ce-cli containerd.io

# Install Certbot
certbot-auto certonly --manual -d *.sish.example.com --agree-tos --no-bootstrap --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
certbot certonly –manual -d *.sish.example.com –agree-tos –no-bootstrap –manual-public-ip-logging-ok –preferred-challenges dns-01 –server https://acme-v02.api.letsencrypt.org/directory

# Install Keys
curl https://github.com/my_github_username.keys > ~/sish/pubkeys/my_github_username
cp -f /etc/letsencrypt/live/sish.example.com-0001/* ~/sish/ssl/
ssh-keygen
ln -s ~/.ssh/id_rsa ~/sish/ssh_key

# Run Sish
cat << "EOF" > /root/sish/docker-start.sh
/usr/bin/docker run --name sish \
  -v ~/sish/ssl:/ssl \
  -v ~/sish/keys:/keys \
  -v ~/sish/pubkeys:/pubkeys \
  --restart unless-stopped \
  --net=host antoniomika/sish:latest \
  -sish.addr=sish.example.com:2222 \
  -sish.adminenabled=true \
  -sish.auth=false \
  -sish.bindrandom=false \
  -sish.domain=sish.example.com \
  -sish.forcerandomsubdomain=false \
  -sish.http=:80 \
  -sish.https=:443 \
  -sish.httpsenabled=true \
  -sish.httpspems=/ssl \
  -sish.keysdir=/pubkeys \
  -sish.pkloc=/keys/ssh_key \
  -sish.redirectrootlocation=https://example.com/ \
  -sish.serviceconsoleenabled=true
EOF

cat << EOF > /etc/systemd/system/docker-sish.service
# Thanks to https://blog.container-solutions.com/running-docker-containers-with-systemd

[Unit]
Description=Sish container
Requires=docker.service
After=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker stop sish
ExecStartPre=-/usr/bin/docker rm sish
ExecStartPre=/usr/bin/docker pull antoniomika/sish:latest
ExecStart=/bin/bash /root/sish/docker-start.sh
ExecStop=/usr/bin/docker stop sish
RemainAfterExit=true

[Install]
WantedBy=default.target
EOF

systemctl enable docker-sish
systemctl start docker-sish


#### RUN AT LOCAL to start tunnel
cat << "EOF" > /usr/local/bin/sish
#/bin/bash
ssh -p 2222 -R $1:80:localhost:80 root@sish.example.com
EOF
chmod +x /usr/local/bin/sish


# REF : https://derrick.blog/2020/01/26/open-source-ngrok-alternative/
