# S3 Terraform Module (Storage and Remote Backend)

---

**MODULE OVERVIEW:**
This Terraform module provisions an **Amazon S3 bucket** for storage, backup, or remote Terraform state management.
It supports **private access, versioning, encryption**, and **force deletion** options for complete lifecycle control.
The bucket can also be used as a **remote backend** for Terraform, storing state files securely with DynamoDB state locking.

---

**OBJECTIVE:**
To automate the creation and configuration of an Amazon S3 bucket for use as a **storage resource** or **Terraform backend**, following security and cost-optimization best practices.

---

**MODULE FEATURES:**

1. Creates an S3 bucket with a unique name using random suffix.
2. Enables private access and versioning.
3. Supports optional force deletion of objects during destroy.
4. Can serve as Terraform remote backend.
5. Includes tagging for project identification and auditing.

---

**REQUIRED INPUT VARIABLES:**

| Variable       | Description              | Example           |
| -------------- | ------------------------ | ----------------- |
| project        | Project name for tagging | "project3"        |
| s3_bucket_name | Base name for S3 bucket  | "project3-bucket" |

---

**EXAMPLE USAGE:**

In your root `main.tf` file:

```
module "s3" {
  source          = "./modules/s3"
  project         = var.project
  s3_bucket_name  = var.s3_bucket_name
}
```

**Optional (for remote backend configuration):**

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

---

**RESOURCES CREATED:**

1. **aws_s3_bucket.my_bucket**

   * Creates a private S3 bucket with unique name.
   * Can optionally enable versioning and encryption.
   * Uses force_destroy for automatic cleanup.

2. **aws_s3_bucket_acl.my_bucket_acl** *(optional)*

   * Defines private access control.
   * Ensures no public read/write permissions.

---

**RESOURCE CONFIGURATION DETAILS:**

| Attribute     | Description                                    |
| ------------- | ---------------------------------------------- |
| Bucket Name   | Custom + Random ID suffix to ensure uniqueness |
| ACL           | Private (no public access allowed)             |
| Versioning    | Can be enabled if required                     |
| Encryption    | Server-side encryption available               |
| force_destroy | Deletes objects automatically when destroyed   |

---

**WORKFLOW SUMMARY:**

1. Terraform creates a unique S3 bucket in the defined region.
2. Versioning and access control policies are applied.
3. The bucket can be configured as Terraform’s remote backend.
4. When destroying, objects are auto-deleted (if force_destroy = true).

---

**OUTPUT VARIABLES:**

| Output Name    | Description                   |
| -------------- | ----------------------------- |
| s3_bucket_name | Name of the created S3 bucket |
| s3_bucket_arn  | ARN of the created S3 bucket  |

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
Navigate to **S3 → Buckets** and confirm your bucket has been created successfully.

---

**CLEANUP:**
If you encounter the “BucketNotEmpty” error during destroy:

* Manually empty the bucket in AWS Console, **or**
* Add the line `force_destroy = true` in your S3 resource block.

Then run:

```
terraform destroy -auto-approve
```

---

**REAL-WORLD USE CASES:**

* Remote backend for Terraform state management.
* Application log or data storage.
* Backup and disaster recovery storage.
* Static website hosting (optional).
* File ingestion for serverless pipelines.

---

## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)

