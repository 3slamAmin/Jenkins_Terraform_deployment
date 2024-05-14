variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["172.31.250.0/24"]
}

variable "main_vpc_id" {
 type        = string
 description = "vpc id"
 default     = "vpc-013b0f82220a110fc"
}
variable "main_vpc_gw" {
 type        = string
 description = "gw_id"
 default     = "igw-015eab3ea9e7a46a8"
}
variable "artifact_url" {
 type        = string
 description = "version of release"
 default     = "https://github.com/3slamAmin/Github-CICD/releases/latest/download/dist.tar.gz"
}