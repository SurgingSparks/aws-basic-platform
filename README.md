# aws-basic-platform

# dev01 Database Stack Guide

This stack provisions a **private, single-AZ PostgreSQL instance** that shares the dev01 VPC with your application servers. Use this guide to understand what Terraform builds, how to retrieve credentials, and how to reach the database from your private EC2 instance for smoke tests.

## Architecture summary
- **Engine & sizing:** PostgreSQL 15.4 running on `db.t3.micro` with 20 GiB of GP3 storage. Defaults are tuned for development workloads and can be overridden via stack variables.
- **Networking:** The instance resides in the existing dev01 private subnet and is *not* publicly accessible. The database security group only permits TCP 5432 from within the VPC CIDR. Outbound traffic is fully open so the instance can reach AWS services for maintenance.
- **State integration:** The stack reads the network state to resolve the VPC ID, private subnet ID, and CIDR, ensuring consistency with the app and network stacks.
- **Password management:** A random, 20-character password is generated at deploy time and exported as a sensitive Terraform output (`db_master_password`).

## Terraform inputs
All tunables live in [`variables.tf`](./variables.tf). Key settings you might adjust:

| Variable | Purpose | Default |
| --- | --- | --- |
| `db_engine_version` | PostgreSQL engine version | `15.4` |
| `db_instance_class` | Instance size | `db.t3.micro` |
| `db_allocated_storage_gib` | Storage size | `20` |
| `db_backup_retention_days` | Automated backup retention | `1` |
| `db_multi_az` | Toggle for Multi-AZ deployments | `false` |
| `db_skip_final_snapshot` | Skip final snapshot on destroy (dev safety) | `true` |

Update these values via a `.tfvars` file or GitHub Actions inputs if you promote this stack beyond development.

## Deploying with GitHub Actions
The reusable workflow accepts `stack: db`. To plan or apply the database stack:

1. Open **Actions → tf-dev01 → Run workflow**.
2. Choose `stack: db` and select `action: plan` or `action: apply`.
3. (For destroy) enter `destroy dev01 db` in the confirmation field to unblock the job.

The workflow runs `terraform init` and `terraform plan/apply` against `envs/dev01/db` using OIDC-backed credentials.

## Retrieving connection details
After a successful apply, pull the connection info from Terraform:

```bash
terraform -chdir=envs/dev01/db output db_endpoint
terraform -chdir=envs/dev01/db output db_port
terraform -chdir=envs/dev01/db output -json db_master_password | jq -r '.'
```

Alternatively, if you deployed via GitHub Actions, inspect the **Plan/Apply** job logs; the plaintext outputs (endpoint, port, identifier) appear near the end, and the sensitive password is available under **View raw logs** for the `db_master_password` output.

## Connecting from the private EC2 instance
1. **Reach the private instance:** From your workstation, SSH into the public server (`srv01`), then hop to the private server (`srv02`) using its private IP.
2. **Install a PostgreSQL client** (Amazon Linux example):
   ```bash
   sudo dnf install -y postgresql15
   ```
3. **Connect with `psql`:**
   ```bash
   PGPASSWORD='<db_master_password>' psql \
     --host '<db_endpoint_without_port>' \
     --port 5432 \
     --username app_admin \
     --dbname appdb
   ```
   Replace the placeholder values with the outputs you retrieved earlier. The security group allows traffic because the instance runs inside the same VPC CIDR.

## Smoke-test queries
Once connected, validate connectivity with simple SQL:

```sql
SELECT version();
SELECT current_database(), current_user;
CREATE TABLE IF NOT EXISTS healthcheck(id serial PRIMARY KEY, checked_at timestamptz DEFAULT now());
INSERT INTO healthcheck DEFAULT VALUES RETURNING *;
```

Drop the table afterwards if you only need a transient test.

## Maintenance tips
- **Password rotation:** Re-run `terraform apply` with `random_password` tainted to force rotation (`terraform -chdir=envs/dev01/db taint random_password.db_master`).
- **Enabling Multi-AZ:** Set `db_multi_az = true` *after* provisioning an additional private subnet in a different AZ and updating the network outputs (`private_subnet_ids`).
- **Backups & deletion protection:** Increase `db_backup_retention_days` or enable `db_deletion_protection` when moving towards production.

For any changes, run `terraform plan` before `apply` to review the impact.
