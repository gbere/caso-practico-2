#!/usr/bin/env bash

# Generar par de claves SSH en el nodo de control.
ssh-keygen -m PEM -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa_cp2 <<< y

# Inicialice un directorio de trabajo de Terraform nuevo o existente creando
# archivos iniciales, cargar cualquier estado remoto, descargar módulos, etc.
terraform init

# Reescribe todos los archivos de configuración de Terraform a un formato canónico. Ambos
# los archivos de configuración (.tf) y los archivos de variables (.tfvars) se actualizan.
terraform fmt

# Validar los archivos de configuración.
terraform validate

# Genera un plan de ejecución especulativo, mostrando qué acciones Terraform
# debería aplicar en la configuración actual.
terraform plan

# Crea o actualiza la infraestructura según los archivos de configuración
# de Terraform en el directorio actual.
terraform apply -auto-approve
