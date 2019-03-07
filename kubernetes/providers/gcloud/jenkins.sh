gcloud container clusters create jenkins-cluster
kubectl create configmap nginx-jenkins-conf --from-file=../../nginx/jenkins_proxy.conf
kubectl create secret generic tls-certs --from-file=../../tls/

# #Create persistent storage with NFS service
kubectl create -f ../../volumes/provisioner/nfs-server-gce-pv.yaml
kubectl create -f ../../volumes/nfs-server-rc.yaml
kubectl create -f ../../volumes/nfs-server-service.yaml
kubectl create -f ../../volumes/nfs-pv.yaml
kubectl create -f ../../volumes/nfs-pvc.yaml

for i in jenkins; do
  kubectl create -f ../../deployments/$i.yaml
  kubectl create -f ../../services/$i.yaml
done
