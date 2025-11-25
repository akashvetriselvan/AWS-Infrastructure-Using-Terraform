DynamoDB Terraform Module (Remote State Locking and Metadata Storage)

---

**MODULE OVERVIEW:**
This Terraform module provisions an **Amazon DynamoDB table** that is primarily used for **Terraform state locking**.
It ensures that multiple users or CI/CD pipelines do not perform concurrent Terraform operations on the same state file.
The table can also be reused for lightweight metadata storage in other AWS workflows.

---

**OBJECTIVE:**
To implement **safe, concurrent Terraform operations** using AWS DynamoDB as a lock mechanism for remote state stored in Amazon S3.

---

**MODULE FEATURES:**

1. Creates a DynamoDB table for Terraform state locking.
2. Uses **PAY_PER_REQUEST** billing for cost efficiency.
3. Sets the **LockID** attribute as the partition key.
4. Can be customized for multi-environment setups (dev, stage, prod).
5. Fully compatible with Terraform S3 backend configuration.

---

**REQUIRED INPUT VARIABLES:**

| Variable   | Description                     | Example               |
| ---------- | ------------------------------- | --------------------- |
| project    | Name of the project for tagging | "project3"            |
| table_name | Name of the DynamoDB table      | "project3-lock-table" |

---

**EXAMPLE USAGE:**

In your root `main.tf` file, include the module as shown below:

```
module "dynamodb" {
  source      = "./modules/dynamodb"
  project     = var.project
  table_name  = "project3-lock-table"
}
```

Then, in your Terraform backend configuration:

```
terraform {
  backend "s3" {
    bucket         = "project3-bucket-xxxx"
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "project3-lock-table"
    encrypt        = true
  }
}
```

---

**RESOURCES CREATED:**

1. **aws_dynamodb_table.lock_table**

   * Creates a DynamoDB table for state locking.
   * Table Name: project3-lock-table
   * Partition Key: LockID
   * Billing Mode: PAY_PER_REQUEST (auto scales read/write capacity)

---

**TABLE CONFIGURATION DETAILS:**

| Attribute | Type   | Description                                     |
| --------- | ------ | ----------------------------------------------- |
| LockID    | String | Primary key used by Terraform for state locking |

Additional configuration:

* On-demand billing ensures cost efficiency.
* Encrypted by AWS automatically.
* Highly available and replicated across multiple AZs.

---

**WORKFLOW SUMMARY:**

1. Terraform initializes and references this DynamoDB table.
2. When `terraform apply` or `terraform destroy` is executed, Terraform checks for an active lock.
3. If another process is running, the state file is locked and other processes are blocked.
4. Once the operation completes, the lock entry is released automatically.

This mechanism prevents state corruption and ensures safe, collaborative Terraform workflows.

---

**OUTPUT VARIABLES:**

| Output Name         | Description                        |
| ------------------- | ---------------------------------- |
| dynamodb_table_name | Name of the created DynamoDB table |
| dynamodb_table_arn  | ARN of the created DynamoDB table  |

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
Navigate to **DynamoDB → Tables** and confirm that the table has been created successfully.

---

**CLEANUP:**
To delete the DynamoDB table created by this module:

```
terraform destroy -auto-approve
```

---

**REAL-WORLD USE CASES:**

* Remote backend state locking for Terraform in S3.
* Preventing concurrent updates in multi-user or CI/CD environments.
* Metadata or configuration storage for serverless applications.
* Version control for state-driven deployments.

---

**BENEFITS:**

* Prevents Terraform state corruption.
* Enables safe, parallel team operations.
* Cost-efficient and scalable (on-demand billing).
* Fully managed and serverless (no maintenance).
* Integrates seamlessly with S3 remote backend.

---


## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)

---

