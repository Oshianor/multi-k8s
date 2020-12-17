docker build -t oshianor/multi-client:latest -t oshianor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oshianor/multi-server:latest -t oshianor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oshianor/multi-worker:latest -t oshianor/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push oshianor/multi-client:latest
docker push oshianor/multi-client:$SHA
docker push oshianor/multi-server:latest
docker push oshianor/multi-server:$SHA
docker push oshianor/multi-worker:latest
docker push oshianor/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oshianor/multi-server:$SHA
kubectl set image deployments/client-deployment client=oshianor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oshianor/multi-worker:$SHA