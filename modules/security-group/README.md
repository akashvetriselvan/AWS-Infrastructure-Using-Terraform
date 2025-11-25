# Security Group Terraform Module (Network Access Control)

---

**MODULE OVERVIEW:**
This Terraform module provisions an **AWS Security Group (SG)** that controls inbound and outbound traffic to EC2 instances or other AWS resources within a VPC.
It defines **firewall rules** to allow only authorized traffic (e.g., SSH, HTTP) while blocking all unauthorized access, ensuring a secure network boundary for your infrastructure.

---

**OBJECTIVE:**
To automate the creation and management of secure, reusable Security Groups for AWS resources using Terraform — ensuring consistent access control across environments.

---

**MODULE FEATURES:**

1. Creates a Security Group within a specified VPC.
2. Allows inbound SSH (port 22) and HTTP (port 80) access.
3. Restricts all other inbound connections.
4. Allows outbound traffic to all destinations (default AWS behavior).
5. Supports tagging for resource identification.

---

**REQUIRED INPUT VARIABLES:**

| Variable      | Description                                               | Example                                                                         |
| ------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------- |
| project       | Project name for tagging                                  | "project3"                                                                      |
| vpc_id        | ID of the VPC in which the Security Group will be created | module.vpc.vpc_id                                                               |
| ingress_rules | List of inbound rules (ports, protocols, sources)         | [{from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]}] |
| egress_rules  | List of outbound rules (ports, protocols, destinations)   | Default: allow all                                                              |

---

**EXAMPLE USAGE:**

In your root `main.tf` file:

```
module "security_group" {
  source  = "./modules/security-group"
  project = var.project
  vpc_id  = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
```

---

**RESOURCES CREATED:**

1. **aws_security_group.ec2_sg**

   * Creates a Security Group with custom inbound and outbound rules.
   * Associates it with the target VPC.
   * Provides a unique SG ID for use in EC2 or other services.

2. **aws_security_group_rule.ingress/egress** *(optional)*

   * Defines rule-based configuration for multiple ports and protocols.
   * Supports both IPv4 and IPv6 CIDR blocks.

---

**RESOURCE CONFIGURATION DETAILS:**

| Attribute     | Description                                        |
| ------------- | -------------------------------------------------- |
| VPC ID        | Specifies the network scope for the Security Group |
| Ingress Rules | Defines allowed inbound connections                |
| Egress Rules  | Defines allowed outbound connections               |
| Protocol      | TCP/UDP/ICMP                                       |
| Ports         | Defines allowed or restricted ports                |
| CIDR Blocks   | Defines trusted IP address ranges                  |
| Tags          | Adds project-level identification for organization |

---

**WORKFLOW SUMMARY:**

1. Terraform reads VPC ID and rule definitions from input variables.
2. A new Security Group is created in the target VPC.
3. Ingress and egress rules are attached.
4. SG ID is exported for use by the EC2 module.
5. EC2 instance automatically inherits these access rules.

---

**OUTPUT VARIABLES:**

| Output Name | Description                      |
| ----------- | -------------------------------- |
| sg_id       | ID of the created Security Group |
| sg_name     | Name of the Security Group       |
| sg_arn      | ARN of the Security Group        |

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
Navigate to **VPC → Security Groups** and confirm that your Security Group has been created successfully with the specified rules.

---

**CLEANUP:**
To delete the Security Group:

```
terraform destroy -auto-approve
```

If the SG is still attached to any EC2 instance, Terraform will block deletion until the dependency is removed.

---

## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)

---
