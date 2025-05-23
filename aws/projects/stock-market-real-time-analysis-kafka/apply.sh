# update backend.conf
state_bucket=$(yq e '.global.state_bucket' config.yaml)
sed -i "s/^bucket = .*/bucket = \"${state_bucket}\"/" backend.conf
region=$(yq e '.global.region' config.yaml)
sed -i "s/^region = .*/region = \"${region}\"/" backend.conf

#Create VPC
echo "--------------------"
echo "Create VPC"
echo "--------------------"
cd vpc
rm backend.conf
ln -s ../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve

#Create Subnets
echo "--------------------"
echo "Create Subnets"
echo "--------------------"
cd ../subnet
rm backend.conf
ln -s ../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve

# #Spin up elk vm
# echo "-----------------------"
# echo "Create ELK VM"
# echo "-----------------------"
# cd ../vm/elk
# rm backend.conf
# ln -s ../../backend.conf backend.conf
# terraform init -backend-config=backend.conf
# terraform plan
# terraform apply --auto-approve

# #Spin up app vm
# echo "-----------------------"
# echo "Create App VM"
# echo "-----------------------"
# cd ../app
# rm backend.conf
# ln -s ../../backend.conf backend.conf
# sed "s/xyz/$(cat ../elk/external-ip.txt)/g" template > filebeat.sh
# terraform init -backend-config=backend.conf
# terraform plan
# terraform apply --auto-approve

# #Configure Firewall
# echo "-----------------------"
# echo "Create Firewall"
# echo "-----------------------"
# cd ../../firewall
# rm backend.conf
# ln -s ../backend.conf backend.conf
# terraform init -backend-config=backend.conf
# terraform plan
# terraform apply --auto-approve

# cd ../
# STATE_BUCKET=$(yq eval '.global.state_bucket' config.yaml)
# PROJECT_ID=$(yq eval '.global.project_id' config.yaml)
# REGION=$(yq eval '.global.region' config.yaml)

# #Upload tf state
# #cd terraform-state-bucket
# gsutil cp terraform-state-bucket/terraform.tfstate gs://$STATE_BUCKET/tf-state/terraform.tfstate


