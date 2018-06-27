# Symphony Terraform Examples
Examples of using the Terraform AWS provider against Stratoscale Symphony

## Before You Begin - Symphony Setup

Here are the setup tasks you need to do within the Symphony GUI, before you can run Terraform against Symphony.

### Create a dedicated VPC-enabled project for Terraform

Before you can use Terraform against Stratoscale Symphony, you need to create a Symphony project that is dedicated for use only by the AWS API (including Terraform):

* You use this project and its access/secret keys for all Terraform operations.

* You do NOT use this project for any non-AWS Symphony actions.

Benefits:

Once you create this project, you associate it with a VPC. The VPC automatically provides default values for a subnet and routing table. 

You also associate this project with a Symphony shared edge network, which becomes the VPC's default internet gateway.

**Prerequisites for creating the VPC-enabled project**

* You must be a Symphony tenant admin to create the project.

* A shared edge network must already exist in your Symphony region.

**To create a VPC-enabled project for use by Teraform:**

1. Within the Symphony GUI, create the project: 

**Menu** > **Account Management** > **Accounts** > select an account > **Create Project**

Specify a name (such as "Terraform" in this example) and optional description for the project.

2. Associate an existing user with the Terraform project:

Highlight the Terraform project you just created, then click **Assign Users**: 

Fill in these fields:

User: select a user from the drop down list

Project Roles: select Tenant Admin

3. Provision a VPC for the Terraform project.

Click the **name** of the project to display the details page, then click **Provision VPC**

From the Edge Network drop down menu, select a shared edge network.

**Important** 

This edge network serves as the default internet gateway for the VPC that you are associating with this project. So, at this point, the VPC associated with the Terraform project you just created contains:

* A default internet gateway

* A default subnet

* A default route table

4. Next, you need to create credentials (access and secret key) for accessing this VPC from Terraform. Note that each project has its own access/secret keys. This means that when you pass in these keys to Terraform, you are telling Terraform what Symphony VPC/project to access.

To create access keys for the Terraform project:

Click Hi *user_name* > Access Keys > Create

The system displays the Access and Secret keys. To copy each key to the clipboard, click the clipboard icon to the right of the key. 

### Get the AWS ID for an image

Whenever you want to use Terraform to create an instance in Symphony, you need to pass in the AMI ID of the image.

To get the AWS ID from Symphony:

From within the GUI, click **Menu** > **Applications** > **Images**

Highlight the image whose ID you want and scroll down to the bottom of the page to find the AWS ID value -- it has a format like this:

ami-1b8ecb82893a4d1f9d500ce33d90496c

Tip: If you see a truncated version of the ID that ends in an ellipsis (three dots) ... then change the resolution of your screen so that the letters and numbers are very small, and you should be able to see and copy the whole ID.


## Usage Guidelines
1. To easily configure an example to work against your environment, modify the `terrafrom.tfvars` file with the proper values.
2. Make sure you have the latest terraform version deployed
3. For more information, visit terraform documentation at: https://www.terraform.io/docs/providers/aws/index.html
