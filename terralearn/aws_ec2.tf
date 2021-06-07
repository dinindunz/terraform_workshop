resource "aws_instance" "k8_master" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.medium"  

    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    vpc_security_group_ids = [ "${aws_security_group.ssh.id}", "${aws_security_group.http_https.id}"  ]
    key_name = "${aws_key_pair.virginia-region-key-pair.id}"

    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = "${file(var.PRIVATE_KEY)}"        
        host        = self.public_ip #"${aws_instance.k8_master.public_ip}"
    }
    provisioner "file" {
        source = "userdata/k8_master.sh"
        destination = "/tmp/k8_master.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/k8_master.sh",
            "sudo -S /tmp/k8_master.sh ${self.private_ip} ${var.K8_POD_CIDR}"
        ]
    }

    tags = {
        "name" = "k8_master"
    }
}

#resource "aws_key_pair" "virginia-region-key-pair" {
#    key_name = var.KEY_NAME
#    public_key = "${file(var.PUBLIC_KEY)}"
#}