# **Deploy Entire AWS Infrastructure Using Terraform**

## **1. Project Overview**

This project demonstrates the deployment of a **complete AWS infrastructure** using **Terraform** with a modular and reusable architecture.
Each AWS service — **VPC, EC2, Security Group, S3, DynamoDB, and CloudWatch** — is implemented as a **separate Terraform module**, ensuring flexibility, scalability, and clean separation of concerns.

The goal is to automate infrastructure provisioning while maintaining best practices in **Infrastructure as Code (IaC)** — including **remote state management, state locking, and monitoring**.

This setup replicates how real DevOps teams deploy, manage, and monitor infrastructure in production environments.

---

## **2. Objectives**

1. Automate AWS infrastructure creation using Terraform.
2. Implement reusable modules for key AWS services.
3. Ensure reliability using remote state management (S3 backend).
4. Enable team collaboration with Terraform state locking (DynamoDB or lockfile).
5. Add observability and alerting using CloudWatch and SNS.
6. Demonstrate end-to-end IaC workflow for production-ready environments.

---

## **3. Architecture Summary**

### **Components Overview:**

| Module         | Purpose                                                                     |
| -------------- | --------------------------------------------------------------------------- |
| VPC            | Creates the core network, subnets, route tables, and Internet Gateway.      |
| Security Group | Defines firewall rules for inbound/outbound access.                         |
| EC2            | Launches a Linux EC2 instance with key pair and security group association. |
| S3             | Creates an S3 bucket for file storage or Terraform remote backend.          |
| DynamoDB       | Used for Terraform state locking and concurrency control.                   |
| CloudWatch     | Monitors EC2 metrics and triggers alerts via SNS.                           |

---

## **4. Tools and Technologies**

| Tool                     | Purpose                                                 |
| ------------------------ | ------------------------------------------------------- |
| **Terraform**            | Infrastructure automation and provisioning              |
| **AWS CLI**              | Configures AWS credentials and command-line interaction |
| **AWS IAM**              | Access and permission management                        |
| **AWS EC2**              | Virtual server hosting                                  |
| **AWS S3**               | Storage and remote Terraform state backend              |
| **AWS DynamoDB**         | State locking for Terraform                             |
| **AWS CloudWatch**       | Performance monitoring and alerting                     |
| **VS Code / PowerShell** | Development and command execution environment           |

---

## **5. Folder Structure**

```
project3/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security-group/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── s3/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── dynamodb/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── cloudwatch/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## **6. Step-by-Step Implementation**

### **Step 1: Configure AWS CLI**

```
aws configure
```

Provide your Access Key, Secret Key, Region (ap-south-1), and output format.

---

### **Step 2: Initialize Terraform**

```
terraform init
```

Initializes the working directory, downloads provider plugins, and sets up the backend.

---

### **Step 3: Validate Configuration**

```
terraform validate
```

Checks for syntax errors and validates your Terraform files.

---

### **Step 4: Review the Plan**

```
terraform plan
```

Displays the resources Terraform will create.

---

### **Step 5: Apply the Configuration**

```
terraform apply -auto-approve
```

Executes the plan and provisions the full AWS infrastructure.

---

### **Step 6: Verify in AWS Console**

Check AWS console for:

* EC2 instance
* VPC and subnet
* S3 bucket
* DynamoDB table
* CloudWatch alarms and SNS subscription

---

## **7. Module Breakdown**

### **VPC Module**

* Creates a custom VPC with specified CIDR range.
* Adds public subnet, internet gateway, and routing table.
* Outputs VPC and subnet IDs for other modules.

### **Security Group Module**

* Allows inbound SSH (22) and HTTP (80) traffic.
* Restricts all other ports.
* Used to control access to the EC2 instance.

### **EC2 Module**

* Launches an EC2 instance using Amazon Linux 2 AMI.
* Associates with security group and subnet.
* Connects using pre-generated key pair.

### **S3 Module**

* Creates an S3 bucket for storage or Terraform backend.
* “force_destroy = true” ensures cleanup during destroy.
* Enables private access only.

### **DynamoDB Module**

* Creates table “project3-lock-table” for state locking.
* Billing mode set to “PAY_PER_REQUEST”.
* Used by Terraform backend to avoid state conflicts.

### **CloudWatch Module**

* Sets up SNS topic for alerting.
* Configures CloudWatch alarm for EC2 CPU utilization above 70%.
* Sends alert emails via SNS.

---

## **8. Remote State Backend Configuration**

```
terraform {
  backend "s3" {
    bucket         = "project3-bucket-xxxx"
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true
  }
}
```

**Purpose:**

* Stores Terraform state securely in S3.
* Locks state to prevent parallel changes.
* Supports collaboration among multiple users.

---

## **9. Monitoring and Alerting (CloudWatch)**

* CloudWatch tracks EC2 metrics such as CPUUtilization, memory, and uptime.
* Alarm triggers SNS email when CPU exceeds 70%.
* SNS Topic created automatically — confirm email subscription to start alerts.

---

## **10. Cleanup and Teardown**

### **Step 1:** Preview Resources to be Destroyed

```
terraform plan -destroy
```

### **Step 2:** Destroy All Resources

```
terraform destroy -auto-approve
```

### **Step 3:** Handle S3 Deletion Errors

If the bucket is not empty:

* Empty manually from AWS Console, or
* Add `force_destroy = true` in S3 module.

### **Step 4:** Clean Local Files

```
rm -rf .terraform/ .terraform.lock.hcl terraform.tfstate*
```

---

## **11. Real-World Use Cases**

* Automated provisioning for development, staging, and production environments.
* Continuous Integration and Continuous Deployment (CI/CD) pipelines using Terraform.
* Infrastructure standardization for large teams.
* Cost-effective environment creation and teardown using IaC.

---

## **12. Benefits**

* Fully automated AWS provisioning
* Reusable, modular architecture
* Safe state management and locking
* Secure and scalable design
* Real-time monitoring with alerts
* Easy cleanup and cost optimization

---

## **13. Results and Verification**

After applying Terraform:

* EC2 instance successfully deployed in VPC.
* S3 bucket created for storage.
* DynamoDB table available for locking.
* CloudWatch alarms configured and functional.
* All resources visible in AWS Management Console.

---

## **14. Author Details**

**Name:** Akash V
**Role:** Cloud & DevOps Engineer
**Skills:** Terraform | AWS | Docker | Kubernetes | CI/CD | Infrastructure as Code
**LinkedIn:** linkedin.com/in/akashv (update link)
**GitHub:** github.com/<your-username>

---

## **15. Project Summary**

This Terraform project represents a real-world example of AWS infrastructure automation using modular design and Infrastructure as Code principles.
It is fully capable of provisioning, managing, monitoring, and destroying infrastructure with a single command.
By integrating S3 and CloudWatch, it also demonstrates professional-level DevOps practices used in production environments.

---

## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)


---
