kubectl delete services jenkins
kubectl delete deployments jenkins
kubectl delete secrets tls-certs
kubectl delete configmaps nginx-jenkins-conf
gcloud container clusters delete jenkins
