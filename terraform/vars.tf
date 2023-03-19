variable "location" {
  type        = string
  description = "Región de Azure donde crearemos la infraestructura"
  default     = "France Central"
}

variable "public_key_path" {
  type        = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default     = "~/.ssh/id_rsa_cp2.pub"
}

variable "ssh_user" {
  type        = string
  description = "Usuario para hacer SSH"
  default     = "azureuser"
}

variable "rg_name" {
  type        = string
  description = "Resource group"
  default     = "rg-cp2"
}

variable "akc_name" {
  type        = string
  description = "Azure kubernetes cluster name"
  default     = "cp2-aks"
}
