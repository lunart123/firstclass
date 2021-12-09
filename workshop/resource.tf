resource "digitalocean_droplet" "work1" {
    image = "ubuntu-20-04-x64"
    name = "work"
    region = "sgp1"
    size = "s-1vcpu-1gb"
    private_networking = true
     ssh_keys = [
    data.digitalocean_ssh_key.ws.id
  ]
  connection {
        type = "ssh"
        user = "root"
       private_key = file("ws")
       host = self.ipv4_address
  }
  provisioner remote-exec {
    inline = [
        "apt update -y",
        "apt upgrade -y",
        "apt install nginx -y",
        "systemctl enable nginx",
         "systemctl start nginx"

    ]
  }
}

output ipv4 {
value = digitalocean_droplet.work1.ipv4_address
} 