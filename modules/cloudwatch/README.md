CloudWatch Monitoring and Alerting (Terraform Module)

---

**MODULE OVERVIEW:**
This Terraform module creates a **CloudWatch monitoring and alerting system** for AWS EC2 instances.
It sets up a **CloudWatch alarm** that monitors CPU utilization and sends alert notifications through **Amazon SNS** (Simple Notification Service).
This module helps ensure proactive monitoring and immediate notifications for performance or resource utilization issues.

---

**OBJECTIVE:**
To enable automated, event-driven monitoring for EC2 instances by configuring CloudWatch alarms and SNS notifications using Infrastructure as Code.

---

**MODULE FEATURES:**

1. Creates an SNS topic for alerts.
2. Subscribes an email address for notifications.
3. Defines a CloudWatch metric alarm for EC2 CPU utilization.
4. Sends alert notifications when thresholds are breached.
5. Provides output values such as SNS Topic ARN.

---

**REQUIRED INPUT VARIABLES:**

| Variable    | Description                          | Example                                                 |
| ----------- | ------------------------------------ | ------------------------------------------------------- |
| project     | Name of the project used for tagging | "project3"                                              |
| instance_id | EC2 instance ID to monitor           | "i-0abc1234def56789"                                    |
| alarm_email | Email address for SNS notifications  | "[youremail@example.com](mailto:youremail@example.com)" |

---

**EXAMPLE USAGE:**

In your root `main.tf` file, call this module as follows:

```
module "cloudwatch" {
  source      = "./modules/cloudwatch"
  project     = var.project
  instance_id = module.ec2.instance_id
  alarm_email = "youremail@example.com"
}
```

---

**RESOURCES CREATED:**

1. **aws_sns_topic.alarm_topic**

   * Creates an SNS topic for alert distribution.
   * Example: project3-alarm-topic

2. **aws_sns_topic_subscription.email_sub**

   * Subscribes the provided email address to the SNS topic.
   * User must confirm via email before receiving alerts.

3. **aws_cloudwatch_metric_alarm.cpu_alarm**

   * Configures an alarm for EC2 CPU utilization.
   * Threshold: 70% average CPU usage over 2 evaluation periods (each 2 minutes).
   * Alarm triggers SNS notification when threshold is breached.

---

**ALARM CONFIGURATION DETAILS:**

Metric Name: CPUUtilization
Namespace: AWS/EC2
Statistic: Average
Period: 120 seconds
Threshold: 70%
Evaluation Periods: 2
Comparison Operator: GreaterThanThreshold
Actions Enabled: True
Alarm Actions: SNS Topic ARN (project3-alarm-topic)

---

**WORKFLOW SUMMARY:**

1. EC2 instance CPU usage increases above 70%.
2. CloudWatch alarm detects high utilization.
3. SNS topic triggers and sends alert email.
4. User receives an email notification with alarm details.

---

**OUTPUT VARIABLES:**

| Output Name   | Description                                |
| ------------- | ------------------------------------------ |
| sns_topic_arn | ARN of the SNS topic created for alerting. |

---

**VALIDATION AND DEPLOYMENT:**

Step 1: Initialize Terraform

```
terraform init
```

Step 2: Validate configuration

```
terraform validate
```

Step 3: Apply module

```
terraform apply -auto-approve
```

Step 4: Confirm SNS subscription
Check your email inbox for a confirmation link from AWS Notifications and approve the subscription to start receiving alerts.

---

**MONITORING AND LOGGING:**

* CloudWatch automatically collects metrics from EC2 instances.
* Alarms and notifications are visible in the AWS Console under CloudWatch → Alarms.
* SNS topic details can be viewed in the SNS Console.

---


## 🧑‍💻 Author

**Akash V** — Cloud & DevOps Engineer ☁️
Specializing in Serverless Architectures, AWS Automation, and CI/CD Pipelines.
🌍 [LinkedIn](https://linkedin.com/in/akashvetriselvan/) | [GitHub](https://github.com/akashvetriselvan)

---
