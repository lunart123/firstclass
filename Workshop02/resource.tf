resource "digitalocean_droplet" "ansy" {
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
 
}

output ipv4 {
value = digitalocean_droplet.ansy.ipv4_address
} 

resource local_file droplet_info {
    filename = "inventory.yml"
    content = templatefile("inventory.yml.tpl", {
        ipv4 = digitalocean_droplet.ansy.ipv4_address
    })
    file_permission = "0644"
}