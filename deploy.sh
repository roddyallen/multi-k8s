docker build -t cumulus96/multi-client-k8s:latest -t cumulus96/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t cumulus96/multi-server-k8s-pgfix:latest -t cumulus96/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t cumulus96/multi-worker-k8s:latest -t cumulus96/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push cumulus96/multi-client-k8s:latest
docker push cumulus96/multi-server-k8s-pgfix:latest
docker push cumulus96/multi-worker-k8s:latest

docker push cumulus96/multi-client-k8s:$SHA
docker push cumulus96/multi-server-k8s-pgfix:$SHA
docker push cumulus96/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cumulus96/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=cumulus96/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=cumulus96/multi-worker-k8s:$SHA