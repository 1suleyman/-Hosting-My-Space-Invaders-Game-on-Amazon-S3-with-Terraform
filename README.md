# 🌌 Hosting My Space Invaders Game on Amazon S3 with Terraform

I decided to host my **Space Invaders** game on **Amazon S3** using **Terraform**. This makes the game publicly playable without needing a server! 🪣🎮

Terraform allows me to **declare the S3 bucket, public access, bucket policy, website hosting, and game file uploads in code** — reusable, version-controlled, and environment-friendly.

<img width="1944" height="908" alt="image" src="https://github.com/user-attachments/assets/4575f56c-8fd6-482b-a64c-7dedf7bf12ee" />


---

## 📂 Project Structure

```text
space-invaders-terraform/
├── main.tf              # Terraform configuration for S3 bucket, policy, website hosting, and file uploads
├── variables.tf         # Variable declarations
├── terraform.tfvars     # Values for the variables
├── outputs.tf           # Outputs (bucket name, website URL)
└── game/                # Local folder containing game files
    ├── index.html
    ├── style.css
    └── game.js
```

> 💡 All Terraform code files will be uploaded to this repo.
> 🔗 [View Terraform Code in the Repo](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/tree/main/space-invaders-terraform)

---

## 🧩 Terraform Workflow

This project is broken down into **five main steps**:

1. **Define variables**

   * Input variables include the AWS region, S3 bucket name, and local game folder path.
   * Values are set in `terraform.tfvars` for environment-specific overrides.
   * [See variables.tf](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/variables.tf) | [See terraform.tfvars](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/terraform.tfvars)

2. **Create the S3 bucket**

   * Terraform provisions a bucket using the name defined in the variables.
   * The bucket will later host the static website.
   * [See main.tf - bucket creation](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/main.tf)

3. **Configure public access**

   * S3 buckets are private by default.
   * Terraform sets up public access so the game can be viewed by anyone online.
   * [See main.tf - public access configuration](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/main.tf)

4. **Apply bucket policy**

   * Terraform applies a policy granting public read access to all objects in the bucket.
   * This ensures the game files can be loaded in a browser.
   * [See main.tf - bucket policy](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/main.tf)

5. **Enable static website hosting and upload game files**

   * Terraform enables static website hosting with `index.html` as the entry point.
   * All files in the local `game/` folder are uploaded to S3.
   * After deployment, the website URL can be retrieved from outputs.
   * [See main.tf - website configuration and object uploads](https://github.com/1suleyman/-Hosting-My-Space-Invaders-Game-on-Amazon-S3-with-Terraform/blob/main/space-invaders-terraform/main.tf)

---

## ⚡ Deployment Steps

1. **Initialize Terraform**

```bash
terraform init
```

2. **Preview the changes**

```bash
terraform plan
```

3. **Apply the configuration**

```bash
terraform apply
```

* Confirm with `yes`
* Terraform will create the bucket, apply the policy, enable website hosting, and upload all game files

<img width="425" height="37" alt="Screenshot 2025-09-09 at 10 04 00" src="https://github.com/user-attachments/assets/75c5ff49-c468-479c-b7e7-b492c56583ac" />

4. **Retrieve the website URL**

```bash
terraform output website_url
```

<img width="572" height="68" alt="Screenshot 2025-09-09 at 10 04 15" src="https://github.com/user-attachments/assets/367e781d-3439-4741-a51a-c9a651e76974" />

* Open this URL in a browser to play your Space Invaders game!

<img width="1132" height="820" alt="Screenshot 2025-09-09 at 10 04 34" src="https://github.com/user-attachments/assets/64f966c8-4d4d-4883-a191-b13e48d0689d" />

---

## 💡 Notes & Best Practices

* **ACLs vs Bucket Policy:** ACLs control individual objects; bucket policies control the whole bucket.
* **Static website hosting:** All game files must be public to be accessible online.
* **Versioning:** Not required for small portfolio projects; saves storage costs.
* **Production-ready:** For real deployments, consider using **CloudFront** for HTTPS, caching, and global performance.

---

## 📌 References

* [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/index.html)
* [Static Website Hosting on S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
* [Terraform AWS S3 Bucket Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

