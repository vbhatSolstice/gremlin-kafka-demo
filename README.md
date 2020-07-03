# Spinning up VM
gcloud deployment-manager deployments create kafka --config config.yaml

# Kafka startup
Login to the VM and issue:
VM_IP_ADDR=34.68.7.196 docker-compose -f kafka.yml up

#Gremlin to kill containers
sudo docker run -d \    --net=host \    --pid=host \    --cap-add=NET_ADMIN \    --cap-add=SYS_BOOT \    --cap-add=SYS_TIME \    --cap-add=KILL \    -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}" \    -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}" \    -v /var/run/docker.sock:/var/run/docker.sock \    -v /var/log/gremlin:/var/log/gremlin \    -v /var/lib/gremlin:/var/lib/gremlin \    gremlin/gremlin daemon

