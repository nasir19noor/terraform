#Create State Bucket
echo "----------------------------------"
echo "Create Terraform State Bucket"
echo "----------------------------------"
cd terraform-state
terraform init
terraform plan
terraform apply --auto-approve