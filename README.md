# 🌌 Hosting My Space Invaders Game on Amazon S3 with Terraform

I decided to host my **Space Invaders game** on Amazon S3 using **Terraform** to make it publicly playable. This version of the project automates the creation of the **S3 bucket**, **uploads game files**, and **configures static website hosting** — all via **Infrastructure as Code**. By the end, anyone can play my game via a public URL! 🪣🎮

---

## 📋 Project Overview

**Terraform Goal:**
Use Terraform to declaratively provision an S3 bucket, upload my Space Invaders game files, and enable static website hosting so that the game is publicly accessible.

**Key Benefits of Terraform:**

* Infrastructure is **reproducible and version-controlled**
* Easy to **modify or destroy** resources without manual intervention
* Makes my **portfolio project fully automated**

---

## 📦 Terraform Project Structure

```
terraform-space-invaders/
├── main.tf          <-- Terraform configuration for S3 bucket and website hosting
├── variables.tf     <-- Input variables (bucket name, region, game file path)
├── outputs.tf       <-- Outputs (bucket name, website URL)
├── game/            <-- Local folder containing game files
│   ├── index.html
│   ├── style.css
│   └── game.js
└── terraform.tfvars <-- Variable values
```

---

## 🛠 Terraform Steps I Followed

### **Step 1: Configure Terraform Provider**

I set up the **AWS provider** in `main.tf`:

```hcl
provider "aws" {
  region = var.aws_region
}
```

This tells Terraform which **AWS account and region** to use.

---

### **Step 2: Create the S3 Bucket**

```hcl
resource "aws_s3_bucket" "space_invaders" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}
```

**What this does:**

* Creates an S3 bucket with the name I provided
* Enables **public read access**
* Sets up **static website hosting** with `index.html` as the entry point

💡 **Tip:** Terraform automatically ensures that the bucket name is globally unique.

---

### **Step 3: Upload Game Files Using S3 Bucket Objects**

```hcl
resource "aws_s3_bucket_object" "game_files" {
  for_each = fileset("${path.module}/game", "**")

  bucket = aws_s3_bucket.space_invaders.id
  key    = each.value
  source = "${path.module}/game/${each.value}"
  acl    = "public-read"
}
```

**Explanation:**

* Uses `fileset` to **loop over all files** in the local `game/` folder
* Uploads **HTML, CSS, and JS files** individually
* Sets each file to **public-read** so the website can be accessed

💡 **Why each file is public:**
Static website hosting requires all objects to be **public** so browsers can load them.

---

### **Step 4: Output the Website URL**

```hcl
output "website_url" {
  value = aws_s3_bucket.space_invaders.website_endpoint
}
```

This gives me the **S3 website endpoint** once Terraform applies the configuration.

---

## ✅ How I Deployed

1. Ran `terraform init` to initialize the working directory.
2. Ran `terraform plan` to preview changes.
3. Ran `terraform apply` to create the bucket, upload game files, and enable hosting.
4. Verified the **website URL** in the browser — my Space Invaders game loaded perfectly! 🎮

💡 **Silly mistake I fixed:** I initially uploaded the folder itself instead of just the files, which caused a **404 error**. After adjusting the paths in Terraform, everything worked.

---

## 📌 Project Summary

| Step                             | Status | Key Notes                                         |
| -------------------------------- | ------ | ------------------------------------------------- |
| Create S3 bucket                 | ✅      | Bucket created via Terraform; public read enabled |
| Upload game files                | ✅      | HTML, CSS, and JS uploaded automatically          |
| Configure static website hosting | ✅      | Index document set; website endpoint outputted    |

---

## 💡 Notes / Tips

* **Terraform is idempotent:** Running `terraform apply` multiple times won’t break existing resources.
* **ACLs vs. Bucket Policies:** ACLs control individual files; bucket policies can control the whole bucket.
* **Versioning:** Not needed for portfolio projects, helps save costs.
* **CloudFront for Production:** For production sites, add CloudFront for HTTPS, caching, and security.
* **Fileset & Loops:** `fileset` with `for_each` is super handy for bulk file uploads.

---

## 📸 Screenshots

* S3 bucket created (Terraform output)
* Game files uploaded (Terraform plan/apply logs)
* Static website endpoint
* Game playable in browser

---

## ✅ References

* [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
