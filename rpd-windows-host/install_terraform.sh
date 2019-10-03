
# Check the current Terraform version
terraform --version

# Download Terraform
wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip

# Unzip Terraform
unzip terraform_0.11.11_linux_amd64.zip

# Set the PATH environmental variable to Terraform binaries:
export PATH="$PATH:$HOME/terraform"
cd /usr/bin
sudo ln -s $HOME/terraform
cd $HOME
source ~/.bashrc

# CCreate a directory for your Terraform configuration
terraform --version
