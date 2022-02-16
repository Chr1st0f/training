resource "null_resource" "ssh_target" {
    connection {
        type        =   "ssh"
        user        =   var.ssh_user
        host        =   var.ssh_host
        private_key =   file(var.ssh_key)
    }

    provisioner "file" {
        source      =   "${path.module}/${var.docker_file}"
        destination =   "${var.dst_dir}/${var.docker_file}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo rm -f ${var.docker_repo}",
            "sudo apt update -qq >/dev/null",
            "sudo chmod +x ${var.dst_dir}/${var.docker_file}",
            "sudo ${var.dst_dir}/${var.docker_file}"
        ]
    }

    # Start docker
    provisioner "remote-exec" {
        inline = [
            "sudo systemctl enable docker",
            "sudo systemctl restart docker",
            "sudo usermod -aG docker ${var.ssh_user}",
            "sudo rm -f ${var.docker_repo}"
        ]
    }
}
