# Automate Terraform with GitHub Actions


This repo is a companion repo to the [Automate Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions?in=terraform/automation).

# TERRAFORM AND AWS

1. Authentication
    - run `aws configure` from your terminal configure your user with the aws credentials

2. Building you Infrastructure on AWS
    - Create the *** terraform-and-aws *** folder
    - cd into the folder and run the command, `wget https://raw.githubusercontent.com/linuxacademy/content-terraform-2021/main/main_aws.tf -O main.tf` to download the terraform config file into a new file named **main.tf**
    - run `terraform init` to initialize terraform.
    - run `terraform fmt` to ensure your config file is well formatted
    - check the validity by running `terraform validate`
    - run `terraform apply` to provision the infrastructure
    - run `terraform show` to show the current state file or `terraform state list` to show all resources you are managing

2. Defining Input variables
    - run `echo "# variable file" >> variables.tf` to create the variable file
    - copy and paste the **variable block** into your variables file and save
    - go to the *main.tf* and replace the *Name* in the *tag block* with `var.instance_name`
    - then run `terraform apply -var "instance_name=Chimezdev-cloudguru"` to make changes

4. Using Output variables to query data
    - run `wget https://raw.githubusercontent.com/linuxacademy/content-terraform-2021/main/outputs_aws.tf -O outputs.tf` while in your working dir. to download the file into a file named **outputs.tf**
    - when the *apply* command completes you should see some outputs returned in the terminal, or run `terraform output` to see the ouputs displayed.
    - run `terraform destroy` to deprovision your infrastructure

5. Storing Remote State
    ### We will be using **Terraform Cloud** as our remote backend
    - run `vim main.tf` to edit the file using vim or any other text editor you prefer
    - add the following backend block to the *terraform* block
    ```
        backend "remote" {
            organization = "cloudguru-cicd-demo"
            workspaces {
                name= "cicd-project"
            }
        }
    ```
    - run `terraform login` and enter *yes* at the prompt to open terraform cloud on your browser.
    - click on **create api token** and copy the token and paste into your terminal.
    - now run `terraform init` to initialize the remote backend
    - you can now remove the state file store locally by running `rm terraform.tfstate`
    - head back to your browser and visit your terraform cloud page and add your aws credentials as environment variables.
    - when done go to the terminal and run `terraform apply`

    