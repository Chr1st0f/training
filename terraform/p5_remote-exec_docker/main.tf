variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}
variable "start_file" {}
variable "dst_tmp_dir" {}
variable "docker_inst" {}

    # Copy .sh docker installation file 
    # Install docker with the .sh file 

resource "null_resource" "ssh_target" {
    connection {
        type        =   "ssh"
        user        =   var.ssh_user
        host        =   var.ssh_host
        private_key =   file(var.ssh_key)
    }

    provisioner "file" {
        source      =   var.docker_inst
        destination =   "${var.dst_tmp_dir}/${var.docker_inst}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -qq >/dev/null",
            "sudo chmod +x ${var.dst_tmp_dir}/${var.docker_inst}",
            "sudo ${var.dst_tmp_dir}/${var.docker_inst} >/dev/null"
        ]
    }

    # Start docker
    provisioner "remote-exec" {
        inline = [
            "sudo systemctl enable docker",
            "sudo systemctl restart docker",
            "sudo usermod -aG docker ${var.ssh_user}"
        ]
    }
}

output "host" { value = var.ssh_host }
output "user" { value = var.ssh_user }
