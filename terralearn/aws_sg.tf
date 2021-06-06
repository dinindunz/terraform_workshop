#Create Security Group to Allow SSH
resource "aws_security_group" "ssh" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  name = "ssh"

  egress = [ {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = -1      
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  } ]

  ingress = [ {
    description = "Allow SSH traffic"
    from_port = 22   
    to_port = 22   
    protocol = "tcp"            
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  } ]
  tags = {
      "name" = "allow_ssh"
    }
}
#Create Security Group to Allow HTTP/HTTPS
resource "aws_security_group" "http_https" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  name = "http_https"
  egress = [ {
      description = "Allow all outbound traffic"
      from_port = 0
      to_port = 0
      protocol = -1      
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      security_groups = null
      self = null
    } ]

  ingress = [ {
      description = "Allow HTTP traffic"
      from_port = 80
      to_port = 80
      protocol = "tcp"            
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      security_groups = null
      self = null
    },
    {
      description = "Allow HTTPS traffic"
      from_port = 443
      to_port = 443
      protocol = "tcp"            
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      security_groups = null
      self = null
    } ]

    tags = {
      "name" = "allow_http_https"
    }
}