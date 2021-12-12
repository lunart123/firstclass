variable app_count {
    type = number
    default = 3
}

variable app_image {
    type = string
    default = "stackupiss/dov-bear:v2"
}

data docker_image dov-image {
    name = var.app_image
}

variable docker_host {
    type = string
}