Wordpress deployment with RDS, and ELB

-Deploy containerizer WordPress image over Xenial cloud image
-Reference external RDS instance
-Deploy ELB for wp instances

Networks to be provisioned:
- 1 VPC 
- 2 Database subnets 
- 1  Web subnets 
- 2  public subnets 

Resources:

1 ELB
2 web servers (or more) (Ubuntu Xenial with docker container running WordPress)
1 RDS instance (MySql)

Stratoscale Symphony Requirements:
-Load balancing enabled and initialized from the UI
-RDS Enabled with Mysql 5.7 engine initialized
-VPC mode enabled for tenant project
    -Afterwards create a security group (call it open_sg) and find it's UUID via aws cli
        -1 egress rule: any traffic out from anywhere


Tested with: Terraform v0.11.7

Known issues:
-Issue with security groups (needs to be manually specified in variable open_sg)
-2nd VM not deploying (count bug?)