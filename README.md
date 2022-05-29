Build WebServer at bootstrap_action

Using Terraform to build out Apache WebServer at AWS

# Enter your AWS credentials
export AWS_ACCESS_KEY_ID=""\
export AWS_SECRET_ACCESS_KEY=""

# Deploy!
terraform apply --auto-approve

# Destroy
terraform destroy


It will display deployed WebServer ARN.
