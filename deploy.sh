docker build -t paulyip34/multi-client:latest -t paulyip34/multi-clients:$SHA -f ./client/Dockerfile ./client
docker build -t paulyip34/multi-server:latest -t paulyip34/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulyip34/multi-worker:latest -t paulyip34/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paulyip34/multi-client:latest
docker push paulyip34/multi-server:latest
docker push paulyip34/multi-worker:latest
docker push paulyip34/multi-client:$SHA
docker push paulyip34/multi-server:$SHA
docker push paulyip34/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paulyip34/multi-server:$SHA
kubectl set image deployments/client-deployment server=paulyip34/multi-client:$SHA
kubectl set image deployments/worker-deployment server=paulyip34/multi-worker:$SHA

