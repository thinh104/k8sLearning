docker build -t thinh104/multi-client:latest -t thinh104/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thinh104/multi-server:latest -t thinh104/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thinh104/multi-worker:latest -t thinh104/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push thinh104/multi-client:latest
docker push thinh104/multi-server:latest
docker push thinh104/multi-worker:latest

docker push thinh104/multi-client:$SHA
docker push thinh104/multi-server:$SHA
docker push thinh104/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thinh104/multi-server:$SHA
kubectl set image deployments/client-deployment client=thinh104/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thinh104/multi-worker:$SHA