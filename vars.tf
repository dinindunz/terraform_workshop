variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_SECRET_KEY" {
  default = "7kHwezJz97jeolT8U54wn59YxN2s+NqW8c5TQ0ZT"
}

variable "AWS_ACCESS_KEY" {
  default = "AKIAYMBKFILVDPEXAE4Q"
}

variable "KEY_NAME" {
  default = "virginia-region-key-pair"
}

variable "PUBLIC_KEY" {
  default = "key_pairs/virginia-region-key-pair.pub"
}

variable "PRIVATE_KEY" {
  default = "key_pairs/virginia-region-key-pair"
}

variable "AMI" {
  type = map(string)

  default = {
        eu-west-2 = "ami-03dea29b0216a1e03"
        us-east-1 = "ami-09e67e426f25ce0d7"
    }
}

variable "K8_POD_CIDR" {
  default = "192.168.0.0/16"
}