# variables.tf

variable "access_key" {
   default = "<PUT IN YOUR AWS ACCESS KEY or use 'export TF_VAR_access_key='>"
}

variable "secret_key" {
   default = "<PUT IN YOUR AWS SECRET KEY or use 'export TF_VAR_secret_key='>"
}

variable "region" {
   default = "eu-central-1"
}

variable "instanceType" {
   default = "t2.micro"
}

# Ubuntu 22.04
variable "ami" {
   default = "ami-0caef02b518350c8b"
}

variable "keyName" {
   default = "devops-15"
}

variable "keyFile" {
   default = "./devops-15.key"
}

#####################
# instance vars
variable "instanceName" {
   default = "devops-15"
}

variable "securityGroup" {
   default = "devops-15-sg"
}

variable "dataFile" {
   default = "./devops-15.yml"
}

# end of variables.tf
