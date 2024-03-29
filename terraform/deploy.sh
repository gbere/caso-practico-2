#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Generar par de claves SSH en el nodo de control.
ssh-keygen -m PEM -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa_cp2

# Inicialice un directorio de trabajo de Terraform nuevo o existente creando
# archivos iniciales, cargar cualquier estado remoto, descargar módulos, etc.
terraform -chdir=$SCRIPT_DIR init

# Reescribe todos los archivos de configuración de Terraform a un formato canónico. Ambos
# los archivos de configuración (.tf) y los archivos de variables (.tfvars) se actualizan.
terraform -chdir=$SCRIPT_DIR fmt

# Validar los archivos de configuración.
terraform -chdir=$SCRIPT_DIR validate

# Genera un plan de ejecución especulativo, mostrando qué acciones Terraform
# debería aplicar en la configuración actual.
terraform -chdir=$SCRIPT_DIR plan -out=tfplan

# Crea o actualiza la infraestructura según los archivos de configuración
# de Terraform en el directorio actual.
terraform -chdir=$SCRIPT_DIR apply -auto-approve "tfplan"
