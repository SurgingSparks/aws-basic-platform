# ---- srv01 volume ----
resource "aws_ebs_volume" "app_data_srv01" {
  availability_zone = aws_instance.srv01.availability_zone
  size              = var.data_volume_size_gib
  type              = var.data_volume_type
  encrypted         = true
  kms_key_id        = var.kms_key_id

  tags = {
    Name = local.names.vol_app_public
    Role = "app-data"
  }
}

resource "aws_volume_attachment" "app_data_srv01_attach" {
  device_name                  = "/dev/sdf"                    
  volume_id                    = aws_ebs_volume.app_data_srv01.id
  instance_id                  = aws_instance.srv01.id
  stop_instance_before_detaching = false
}

# ---- srv02 volume ----
resource "aws_ebs_volume" "app_data_srv02" {
  availability_zone = aws_instance.srv02.availability_zone
  size              = var.data_volume_size_gib
  type              = var.data_volume_type
  encrypted         = true
  kms_key_id        = var.kms_key_id

  tags = {
    Name = local.names.vol_app_private
    Role = "app-data"
  }
}

resource "aws_volume_attachment" "app_data_srv02_attach" {
  device_name                  = "/dev/sdf"                   
  volume_id                    = aws_ebs_volume.app_data_srv02.id
  instance_id                  = aws_instance.srv02.id
  stop_instance_before_detaching = false
}
