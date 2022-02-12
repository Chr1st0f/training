variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

variable "src_file" {}
variable "dst_file" {}

resource "null_resource" "ssh_target" {
    connection {
        type        =   "ssh"
        user        =   var.ssh_user
        host        =   var.ssh_host
        private_key =   file(var.ssh_key)
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -qq >/dev/null",
            "sudo apt install -qq -y nginx"
        ]
    }
    provisioner "file" {
        source      =   var.src_file
        destination =   var.dst_file
    }
    provisioner "local-exec" {
        command      =   "whoami"
    }
}
output "host" {
    value = var.ssh_host
}
output "user" {
    value = var.ssh_user
}
output "key" {
    value = var.ssh_key
}