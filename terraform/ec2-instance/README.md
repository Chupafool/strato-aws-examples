# Overview - Simple EC2 Instance
This Terraform example creates a very simple EC2 instance from an AMI stored in Symphony.

## Before You Begin - Symphony Setup

Before you can use this Terraform example, you need to do the following tasks within the Symphony GUI:

* Create a dedicated VPC-enabled project for use with Terraform.

* Get the unique access and secret keys for that project.

* Get the ID of the AMI image you will use as the basis for your EC2 instance. This ID must be in AWS ID format.

These taske are described [here](https://github.com/Stratoscale/strato-aws-examples/tree/laurel-symp-basic-setup/terraform#before-you-begin---symphony-setup)

## How to Use
1. Make sure you have the latest versioin of Terraform installed.

2. Modify the `terraform.tfvars` file according to your environment.

3. Run `terraform apply`.

