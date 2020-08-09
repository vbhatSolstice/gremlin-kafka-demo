# Spinning up VM 
gcloud deployment-manager deployments create kafka --config config.yaml

# Kafka startup
Login to the VM and issue:
VM_IP_ADDR=`IP addr of VM` docker-compose -f kafka.yml up

#Gremlin to kill containers
sudo docker run -i     --cap-add=NET_ADMIN     -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}"     -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}"     -v /var/run/docker.sock:/var/run/docker.sock     gremlin/gremlin attack-container <container-id-to-kill> shutdown
  
# Demo on gcp
1. start kafka
2. allow tcp on port 8080
3. Run IBM MQ on GCP and open ports 1414 and 9443
3. gremlin init
4. Deploy Transactions POC to PCF (https://github.com/vbhatSolstice/spring-kafka-txn)

# Run events
`for i in {1..500}; do 
  curl -i -X POST -H "Content-Type: application/json" -d 
    '{"eventId":null,"trade":{"id":"'$i'","type":"Stock","symbol":"MSFT","description":"Microsoft Corp", "instruction":"buy", "quantity":100}}' 
    "https://kafka-demo-responsive-lizard.cfapps.io/tradeEvent"; sleep 1;
done`

# Running IBM MQ
1. docker run \
  --env LICENSE=accept \
  --env MQ_QMGR_NAME=QM1 \
  --publish 1414:1414 \
  --publish 9443:9443 \
  --detach \
  ibmcom/mq
