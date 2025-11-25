# **MODULE NAME:** EC2 Terraform Module (Compute Instance Deployment)

---

**MODULE OVERVIEW:**
This Terraform module provisions an **Amazon EC2 instance** within a custom VPC.
It automates the creation of a lightweight, secure, and fully functional compute environment — ideal for web applications, testing environments, or backend services.
The module integrates seamlessly with **VPC**, **Security Group**, and **CloudWatch** modules to form a complete, production-ready setup.

---

**OBJECTIVE:**
To automate EC2 instance provisioning using Infrastructure as Code (IaC) — ensuring consistent, repeatable deployments and eliminating manual setup.

---

**MODULE FEATURES:**

1. Launches an EC2 instance inside a specified subnet.
2. Associates the instance with a defined security group.
3. Uses a key pair for SSH access.
4. Supports tagging and region customization.
5. Outputs instance details (ID, public IP, and DNS).

---

**REQUIRED INPUT VARIABLES:**

| Variable               | Description                            | Example                       |
| ---------------------- | -------------------------------------- | ----------------------------- |
| project                | Project name used for tagging          | "project3"                    |
| subnet_id              | ID of the subnet where EC2 will launch | module.vpc.subnet_id          |
| vpc_security_group_ids | List of associated security group IDs  | [module.security_group.sg_id] |
| instance_type          | EC2 instance type                      | "t2.micro"                    |
| ami                    | Amazon Machine Image ID                | "ami-0e4e4bff4f3a8f3a7"       |
| key_name               | Existing EC2 key pair name             | "project3-key"                |

---

**EXAMPLE USAGE:**

In your root `main.tf` file, use:

```
module "ec2" {
  source                = "./modules/ec2"
  project               = var.project
  subnet_id             = module.vpc.subnet_id
  vpc_security_group_ids = [module.security_group.sg_id]
  instance_type         = "t2.micro"
  ami                   = "ami-0e4e4bff4f3a8f3a7"
  key_name              = "project3-key"
}
```

---

**RESOURCES CREATED:**

1. **aws_instance.web**

   * Provisions an EC2 instance in the specified subnet.
   * Associates with defined key pair and security group.
   * Uses the Amazon Linux 2 AMI for t2.micro instance type.
   * Automatically assigns a public IP address.

---

**RESOURCE CONFIGURATION DETAILS:**

| Attribute      | Description                                     |
| -------------- | ----------------------------------------------- |
| AMI            | Amazon Machine Image used for the instance      |
| Instance Type  | Defines hardware (e.g., t2.micro for Free Tier) |
| Key Pair       | Allows secure SSH access                        |
| Subnet ID      | Determines where the instance resides           |
| Security Group | Controls inbound/outbound access                |
| Tags           | Labels instance for tracking and organization   |

---

**WORKFLOW SUMMARY:**

1. Terraform reads configuration and initializes EC2 creation.
2. The EC2 instance is deployed within the existing VPC.
3. Security Group and key pair are attached automatically.
4. Public IP and DNS are generated for connection.
5. Outputs provide access information for future use.

---

**OUTPUT VARIABLES:**

| Output Name | Description                              |
| ----------- | ---------------------------------------- |
| instance_id | Unique ID of the created EC2 instance    |
| public_ip   | Public IP address for SSH or HTTP access |
| public_dns  | Public DNS hostname of the instance      |

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
Navigate to **EC2 → Instances** to confirm the instance has been created successfully.

---

**CLEANUP:**
To delete the EC2 instance:

```
terraform destroy -auto-approve
```

Terraform will automatically remove the instance and associated resources provisioned by this module.

---

**REAL-WORLD USE CASES:**

* Hosting web servers, APIs, or application backends.
* Deploying development or staging environments.
* Testing automated infrastructure workflows.
* Demonstrating Infrastructure as Code automation using Terraform.

---

## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)


Would you like me to create the next one for your **VPC module** in the same professional style (matching EC2, DynamoDB, and CloudWatch READMEs)?
