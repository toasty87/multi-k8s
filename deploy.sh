docker build -t jwpacker/mulit-docker-client:latest -t jwpacker/mulit-docker-client:$SHA ./client/Dockerfile ./client
docker build -t jwpacker/mulit-docker-server:latest -t jwpacker/mulit-docker-server:$SHA ./server/Dockerfile ./server
docker build -t jwpacker/mulit-docker-worker:latest -t jwpacker/mulit-docker-worker:$SHA ./worker/Dockerfile ./worker

docker push jwpacker/mulit-docker-client:latest
docker push jwpacker/mulit-docker-server:latest
docker push jwpacker/mulit-docker-worker:latest

docker push jwpacker/mulit-docker-client:$SHA
docker push jwpacker/mulit-docker-server:$SHA
docker push jwpacker/mulit-docker-worker:$SHA
kubectl apply -f k8s --validate=false

kubectl set image deployments/client-deployment client=mulit-docker-client:$SHA
kubectl set image deployments/server-deployment server=mulit-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=mulit-docker-worker:$SHA
