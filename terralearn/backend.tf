terraform {
    backend "s3" {
        bucket = "${var.S3_BACKEND}"
        encrypt = true
        key = "terralearn/state.tfstate" # Where you want to store state in S3
        region = "${var.AWS_REGION}"
    }
}