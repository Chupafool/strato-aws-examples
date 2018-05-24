# RDS Simple Example
This example creates an RDS instance using Terraform. It creates an instance,  
and assigns it a custom parameters group with modified parameters.

> Note: This example provisions a MySQL 5.7 version.

## Getting started
1. Make sure that the database engine you want to provision is enabled in Symphony.

   To enable an engine, from the Symphony GUI, click
   
   **Menu** > **Database** > **Engines** > *click an engine name* > **Enabled**

2. Make sure you have the latest version of Terraform installed.

3. Set these values in the `terraform.tfvars` file:
   
   `symphony_ip`: The IP of your Symphony region
   
   `access_key` and `secret_key`: To get these values, start the Symphony GUI.
   
   In the upper right corner of the GUI, click **Hi username** > **Access Keys**.
   
4. Run `terraform apply`.
