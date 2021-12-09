resource docker_image dov-bear{
    name ="stackupiss/dov-bear:v2"
    keep_locally = true
}

resource docker_container dov-app{
    name = "app0"
    image =docker_image.dov-bear.latest
    
    ports{
        internal =3000
        external =8080
    }
   env = ["INSTANCE_NAME=dov-app" , "INSTANCE_HASH=test"]
}