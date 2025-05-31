variable "username" {
    type        = string
    description = "ACR registry username"
    sensitive = true 
}
variable "password" {
    type        = string
    description = "ACR registry password"
    sensitive = true
}