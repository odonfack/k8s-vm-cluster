https://cert-manager.io/docs/installation/kubectl/
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml

Create the test resources.


$ kubectl apply -f test-resources.yaml
Check the status of the newly created certificate. You may need to wait a few seconds before cert-manager processes the certificate request.

kubectl describe certificate -n cert-manager-test

Clean up the test resources.


$ kubectl delete -f test-resources.yaml
Before continuing, ensure that unwanted cert-manager resources that have been created by users have been deleted. You can check for any existing resources with the following command:


kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces