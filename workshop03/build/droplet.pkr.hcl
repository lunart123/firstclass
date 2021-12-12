variable DO_region {
    type = string
    default = "sgp1"
}

variable DO_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable DO_size {
    type = string
    default = "s-1vcpu-1gb"
}
variable DO_token {
    type = string
    sensitive = true
    default = env("MY_TOKEN")
}



source digitalocean mydroplet {
api_token = var.DO_token
region = var.DO_region
size = var.DO_size
image = var.DO_image
snapshot_name = "mydroplet"
ssh_username = "root"
}
build {
sources = [
"source.digitalocean.mydroplet"
 provisioner ansible {
        playbook_file = "./playbook.yaml"
        extra_arguments = [
            "-e", "public_key_file=${var.public_key}"
        ]
        ]
 }
}

