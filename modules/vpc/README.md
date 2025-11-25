# VPC Terraform Module (Virtual Private Cloud Network Setup)

---

**MODULE OVERVIEW:**
This Terraform module provisions an **Amazon Virtual Private Cloud (VPC)** to create an isolated and secure networking environment for AWS resources.
It sets up essential networking components such as **subnets, route tables, and an internet gateway**, forming the foundation for deploying EC2 instances and other infrastructure resources.

---

**OBJECTIVE:**
To automate the creation of a secure, scalable, and customizable AWS VPC environment using Terraform.
This module provides network segmentation, internet access, and routing configurations that form the backbone of any AWS architecture.

---

**MODULE FEATURES:**

1. Creates a VPC with a customizable CIDR block.
2. Provisions a public subnet for EC2 instances.
3. Configures an Internet Gateway for external connectivity.
4. Creates and associates a route table with the public subnet.
5. Provides output values for VPC, Subnet, and Route Table IDs.

---

**REQUIRED INPUT VARIABLES:**

| Variable           | Description                             | Example       |
| ------------------ | --------------------------------------- | ------------- |
| project            | Project name used for tagging           | "project3"    |
| vpc_cidr           | CIDR block for the VPC                  | "10.0.0.0/16" |
| public_subnet_cidr | CIDR block for the public subnet        | "10.0.1.0/24" |
| availability_zone  | Availability Zone for subnet deployment | "ap-south-1a" |

---

**EXAMPLE USAGE:**

In your root `main.tf` file:

```
module "vpc" {
  source             = "./modules/vpc"
  project            = var.project
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}
```

---

**RESOURCES CREATED:**

1. **aws_vpc.main**

   * Creates a VPC with a user-defined CIDR block.
   * Enables DNS hostnames and support for EC2 instances.

2. **aws_subnet.public**

   * Creates a public subnet within the VPC.
   * Configured in the specified Availability Zone.

3. **aws_internet_gateway.igw**

   * Provides outbound internet connectivity for public subnet instances.

4. **aws_route_table.public_rt**

   * Defines routing rules for internet access.
   * Associates routes with the internet gateway.

5. **aws_route_table_association.public_assoc**

   * Associates the public subnet with the route table, enabling external access.

---

**RESOURCE CONFIGURATION DETAILS:**

| Attribute         | Description                                     |
| ----------------- | ----------------------------------------------- |
| VPC CIDR          | Defines the network range for all subnets       |
| Subnet CIDR       | Defines subnet IP range for EC2 instances       |
| Internet Gateway  | Enables outgoing traffic from the VPC           |
| Route Table       | Directs network traffic to the internet gateway |
| Availability Zone | Specifies location of subnet resources          |

---

**WORKFLOW SUMMARY:**

1. Terraform initializes and provisions a VPC.
2. A subnet is created within the VPC for EC2 or other resources.
3. An Internet Gateway is attached to enable external connectivity.
4. A Route Table is created and associated with the subnet.
5. Outputs provide key identifiers for integration with other modules (EC2, Security Group, etc.).

---

**OUTPUT VARIABLES:**

| Output Name    | Description                        |
| -------------- | ---------------------------------- |
| vpc_id         | ID of the created VPC              |
| subnet_id      | ID of the created subnet           |
| route_table_id | ID of the associated route table   |
| igw_id         | ID of the created Internet Gateway |

---

**VALIDATION AND DEPLOYMENT:**

Step 1: Initialize Terraform

```
terraform init
```

Step 2: Validate Configuration

```
terraform validate
```

Step 3: Apply the Module

```
terraform apply -auto-approve
```

Step 4: Verify in AWS Console
Navigate to **VPC → Your VPCs / Subnets / Route Tables** to confirm all components are created successfully.

---

**CLEANUP:**
To destroy the VPC and its dependencies:

```
terraform destroy -auto-approve
```

Note: AWS will not delete a VPC with dependent resources (like EC2 or SG).
Ensure all dependencies are destroyed first.


---

## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)

---
