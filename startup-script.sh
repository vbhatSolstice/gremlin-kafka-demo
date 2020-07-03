#!/bin/bash
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io -y
usermod -aG docker ${USER}
newgrp docker
curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
apt-get install -y kafkacat
sudo docker run -d \    --net=host \    --pid=host \    --cap-add=NET_ADMIN \    --cap-add=SYS_BOOT \    --cap-add=SYS_TIME \    --cap-add=KILL \    -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}" \    -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}" \    -v /var/run/docker.sock:/var/run/docker.sock \    -v /var/log/gremlin:/var/log/gremlin \    -v /var/lib/gremlin:/var/lib/gremlin \    gremlin/gremlin daemonsudo docker run -d \    --net=host \    --pid=host \    --cap-add=NET_ADMIN \    --cap-add=SYS_BOOT \    --cap-add=SYS_TIME \    --cap-add=KILL \    -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}" \    -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}" \    -v /var/run/docker.sock:/var/run/docker.sock \    -v /var/log/gremlin:/var/log/gremlin \    -v /var/lib/gremlin:/var/lib/gremlin \    gremlin/gremlin daemonkafkacat
apt-get install -y apache2

HTML_START="<html><body><h1>VM Metadata From Startup Script</h1><pre>"
HTML_END="</pre></body></html>"

VM_METADATA=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=text" -H "Metadata-Flavor: Google")

# Encode HTML characters
VM_METADATA=$(echo "$VM_METADATA"|sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')

FILE_CONTENTS="$HTML_START$VM_METADATA$HTML_END"

echo "$FILE_CONTENTS" > /var/www/html/index.html
