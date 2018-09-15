docker build -t tinee/multi-client:latest -t tinee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tinee/multi-server:latest -t tinee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tinee/multi-worker:latest -t tinee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Pushing to regristry.
docker push tinee/multi-client:latest
docker push tinee/multi-server:latest
docker push tinee/multi-worker:latest
docker push tinee/multi-client:$SHA
docker push tinee/multi-server:$SHA
docker push tinee/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=tinee/multi-server:$SHA
kubectl set image deployments/client-deployment client=tinee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tinee/multi-worker:$SHA