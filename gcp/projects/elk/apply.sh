# update backend.conf
state_bucket=$(yq e '.global.state_bucket' config.yaml)
sed -i "s/^bucket = .*/bucket = \"${state_bucket}\"/" backend.conf

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
cd ../subnets
rm backend.conf
ln -s ../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve

#Spin up management app vm
echo "-----------------------"
echo "Create App VM"
echo "-----------------------"
cd ../vm/app
rm backend.conf
ln -s ../../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve

#Spin up management elk vm
echo "-----------------------"
echo "Create ELK VM"
echo "-----------------------"
cd ../elk
rm backend.conf
ln -s ../../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve

#Configure Firewall
echo "-----------------------"
echo "Create Firewall"
echo "-----------------------"
cd ../../firewall
rm backend.conf
ln -s ../backend.conf backend.conf
terraform init -backend-config=backend.conf
terraform plan
terraform apply --auto-approve


cd ../
STATE_BUCKET=$(yq eval '.global.state_bucket' config.yaml)
PROJECT_ID=$(yq eval '.global.project_id' config.yaml)
REGION=$(yq eval '.global.region' config.yaml)


#Upload tf state
#cd terraform-state-bucket
gsutil cp terraform-state-bucket/terraform.tfstate gs://$STATE_BUCKET/tf-state/terraform.tfstate


