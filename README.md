# Spinning up VM
gcloud deployment-manager deployments create kafka --config config.yaml

# Kafka startup
Login to the VM and issue:
VM_IP_ADDR=34.68.7.196 docker-compose -f kafka.yml up

#Gremlin to kill containers
sudo docker run -i     --cap-add=NET_ADMIN     -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}"     -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}"     -v /var/run/docker.sock:/var/run/docker.sock     gremlin/gremlin attack-container <container-id-to-kill> shutdown
  
# Pushing a new image
./gradlew build
docker build --build-arg JAR_FILE=build/libs/*.jar -t gremlin-kafka .
docker tag gremlin-kafka vinayvb/gremlin-kafka:vx
docker push vinayvb/gremlin-kafka:vx

# Demo on gcp
1. start kafka
2. allow tcp on port 8080
3. gremlin init
4. docker run -p 8080:8080 vinayvb/gremlin-kafka:vx

