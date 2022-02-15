variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

variable "src_dir" {}
variable "dst_dir" {}
variable "docker_file" {}


module "docker_install" { 
    ssh_host        =   var.ssh_host
    ssh_user        =   var.ssh_user
    ssh_key        =   var.ssh_key
}
