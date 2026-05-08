aws_region          = "eu-west-3"
az                  = "eu-west-3a"
ami_windows = "ami-09dc233a8e50c0b9d"
ami_ubuntu          = "ami-04df1508c6be5879e"
ssh_public_key_path = "./keys/ymmo-key.pub"
admin_ips           = ["0.0.0.0/0"]

# db_password → ne pas mettre ici, utiliser :
# export TF_VAR_db_password="TonMotDePasse"
# export TF_VAR_db_username="ymmo_admin"
