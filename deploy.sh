#!/usr/bin/env bash

TF_DIR="./terraform"

# desplegamos todos los recursos definidos en terraform
./terraform/deploy.sh

./ansible/deploy.sh

VM1_PUBLIC_IP=$(terraform -chdir=$TF_DIR output -raw vm1_pip)
AKS1_PUBLIC_IP=$(terraform -chdir=$TF_DIR output -raw aks1_pip)
NL='\n\r'

echo -e "${NL}En breve se podra visitar:${NL}${NL}" \
    "   - La máquina virtual de linux con el app symfony demo${NL}" \
    "       -> URL: https:\\\\\\\\${VM1_PUBLIC_IP}\ ${NL}" \
    "       -> Zona segura: Entrar en backend y usar el usario administrador${NL}${NL}" \
    "   - El cluster AKS con adminer y mysql ${NL}"  \
    "       -> URL: http:\\\\\\\\${AKS1_PUBLIC_IP}\ ${NL}" \
    "       -> Servidor: mysql ${NL}" \
    "       -> Usuario: root o unir ${NL}" \
    "       -> Contraseña: unir ${NL}" \
    "       -> Base de datos: unir ${NL}"
