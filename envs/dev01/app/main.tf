# ---- Security group: SSH from your IP only, egress all ----
resource "aws_security_group" "public_ssh" {
  name        = local.names.sg_public_ssh
  description = "Allow SSH from my IP; egress all"
  vpc_id      = local.dev01_vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = local.names.sg_public_ssh }
}

# ---- EC2 instance in the PUBLIC subnet ----
resource "aws_instance" "srv01" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = local.dev01_public_subnet_id
  vpc_security_group_ids = [aws_security_group.public_ssh.id]
  key_name               = var.ssh_key_name
  root_block_device {
    delete_on_termination = true
  }
  tags = { Name = local.names.srv01 }
  
# ---- cloud-init on startup ----
  user_data = <<-EOF
              user_data = <<'EOF'
              #!/bin/bash
              set -euxo pipefail

              dnf -y install xfsprogs

              # Wait for the non-root NVMe disk (root is nvme0n1)
              for i in {1..30}; do
                DATA_DEV=$(lsblk -ndo NAME,TYPE | awk '$2=="disk"{print "/dev/"$1}' | grep -v nvme0n1 | head -n1 || true)
                [ -n "$DATA_DEV" ] && break
                sleep 2
              done
              [ -z "$DATA_DEV" ] && exit 0

              # Make filesystem if none exists (idempotent)
              if ! blkid "$DATA_DEV" >/dev/null 2>&1; then
                mkfs.xfs -f "$DATA_DEV" -L appdata
              fi

              mkdir -p /app
              # Persist by UUID so it survives reattach/rename
              UUID=$(blkid -s UUID -o value "$DATA_DEV")
              grep -q "$UUID" /etc/fstab || echo "UUID=$UUID /app xfs defaults,nofail 0 2" >> /etc/fstab

              mount -a
              echo "stage2 ok" > /app/keepme.txt
              EOF

}
