#!/usr/bin/env bash

TF_DIR="./terraform"
REGISTRY_LOGIN_SERVER=$(terraform -chdir=$TF_DIR output -raw container_registry_login_server)
IMG_DIR_SF_DEMO="./podman/symfony-demo/"
IMG_NAME_SF_DEMO="symfony-demo:casopractico2"

# ./terraform/deploy.sh

# nos identificamos en nuestro registro privado
podman login --username $(terraform -chdir=$TF_DIR output -raw container_registry_admin_username) \
    --password $(terraform -chdir=$TF_DIR output -raw container_registry_admin_password) \
    $REGISTRY_LOGIN_SERVER

# generamos sf-demo.key, sf-demo.csr, sf-demo.crt y dh2048.pem
${IMG_DIR_SF_DEMO}generate-ssl.sh

# generamos la imagen symfony-demo:casopractico2
podman build -t $IMG_NAME_SF_DEMO $IMG_DIR_SF_DEMO
IMG_SF_DEMO_DESTINATION=$REGISTRY_LOGIN_SERVER/$IMG_NAME_SF_DEMO
# tageamos la imagen con nuestro registy + nombre-de-imagen:tag
podman tag $IMG_NAME_SF_DEMO $IMG_SF_DEMO_DESTINATION
# y la subimos
podman push $IMG_SF_DEMO_DESTINATION
