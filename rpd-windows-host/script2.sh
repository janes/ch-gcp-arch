gcloud compute networks create securenetwork --subnet-mode=custom
gcloud compute firewall-rules create f1 --network securenetwork --allow tcp,udp,icmp --source-ranges 10.130.0.0/20
gcloud compute firewall-rules create f2 --network securenetwork --allow tcp:22,tcp:3389,icmp
gcloud compute networks subnets create securesubnetwork --network=securenetwork --region=us-central1 --range=10.0.0.0/24 --enable-private-ip-google-access
gcloud compute instances create vm-bastionhost --zone=us-central1-a --subnet=securesubnetwork --network=securenetwork --image-project windows-cloud --image-family=windows-2016
gcloud compute instances get-serial-port-output vm-bastionhost --zone us-central1-a
gcloud compute instances create vm-securehost --zone=us-central1-a --subnet=securesubnetwork --network=securenetwork --image-project windows-cloud --image-family=windows-2016
gcloud compute reset-windows-password vm-bastionhost --user app_admin --zone us-central1-a
gcloud compute reset-windows-password vm-securehost --user app_admin --zone us-central1-a
gcloud beta compute firewall-rules create securenetwork-allow-internal --network securenetwork --action ALLOW --direction INGRESS --rules all --source-ranges 10.0.0.0/24
gcloud beta compute firewall-rules create securenetwork-allow-rdp --network securenetwork --action ALLOW --direction INGRESS --rules tcp:3389 --target-tags=bastionhost
gcloud beta compute firewall-rules create securenetwork-allow-http --network securenetwork --action ALLOW --direction INGRESS --rules tcp:80 --target-tags=securehost
gcloud compute instances add-tags vm-securehost --zone=us-central1-a --tags securehost