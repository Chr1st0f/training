variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

variable "src_dir" {}
variable "dst_dir" {}
variable "docker_file" {}
variable "docker_repo" {}

module "docker_install" { 
    source = "./modules/docker_install"
    # Transfer of vars in the module
    ssh_host = var.ssh_host
    ssh_user = var.ssh_user
    ssh_key = var.ssh_key
    src_dir = var.src_dir
    dst_dir = var.dst_dir
    docker_file = var.docker_file
    docker_repo = var.docker_repo
}

module "docker_run" {
    source = "./modules/docker_run" 
    ssh_host = var.ssh_host
}

output "ip_container" {
    value = module.docker_run.ip_docker
}