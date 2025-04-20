#Configure GKE
echo "-----------------------"
echo "Create GKE"
echo "-----------------------"
cd gke
rm backend.conf
ln -s ../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve