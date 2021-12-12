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

 provisioner remote-exec {
        inline = [
            "apt update -y",
            "apt upgrade -y",
            "apt install nginx -y",
            "systemctl enable nginx",
            "systemctl start nginx",
        ]
    }

    provisioner file {
        source = local_file.nginx-conf.filename
        destination = "/etc/nginx/nginx.conf"
    }

    provisioner remote-exec {
        inline = [
            "nginx -s reload"
        ]
    }
 
resource docker_container dov-container {
    count = var.app_count
    name = "dov-${count.index}"
    image = data.docker_image.dov-image.id
    ports {
        internal = 3000
    }
    env = [ "INSTANCE_NAME=dov-${count.index}" ]
}

// Templating
resource local_file nginx-conf {
    filename = "nginx.conf"
    content = templatefile("nginx.conf.tpl", {
        docker_host = var.docker_host
        ports = flatten(docker_container.dov-container[*].ports[*].external)
    })
    file_permission = "0644"
}