# Spinning up VM 
gcloud deployment-manager deployments create kafka --config config.yaml

# Kafka startup
Login to the VM and issue:
VM_IP_ADDR=`IP addr of VM` docker-compose -f kafka.yml up

# Gremlin setup
- Signup for a gremlin account
- Note the Team_Id and Team_Secret
  
# Demo on gcp
1. start kafka: The docker script runs a 3 zookeeper, 3 broker Kafka cluster with min_insync_replicas=2
2. allow tcp on port 8080
3. Run IBM MQ on GCP and open ports 1414 and 9443
4. Install gremlin on the VM in GCP
5. Start the gremlin client and daemon with: gremlin init
6. Deploy Transactions POC to PCF (https://github.com/vbhatSolstice/spring-kafka-txn)
7. Open a terminal on your machine and run the shell script below (Run events) to submit 500 events with a 1 second delay to Kafka
8. Run scenarios on Gremlin to first bring down a zookeper instance and a broker and make sure you are still able to post events by looking at the terminal
9. Bring down the second broker and now you will see that you can't submit any more events

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
