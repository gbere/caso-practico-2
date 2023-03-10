#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASE_PATH="${SCRIPT_DIR}/symfony-demo/ssl/private/"

# Generar certificados
echo $BASE_PATH
openssl genrsa -out ${BASE_PATH}sf-demo.key 2048
openssl req -key ${BASE_PATH}sf-demo.key -new -out ${BASE_PATH}sf-demo.csr -subj "/C=ES/ST=Lleida/L=Lleida/O=DevOps/OU=Ejemplo/CN=vm1"
openssl x509 -signkey ${BASE_PATH}sf-demo.key -in ${BASE_PATH}sf-demo.csr -req -days 365 -out ${BASE_PATH}sf-demo.crt

openssl dhparam -out ${BASE_PATH}dh2048.pem 2048
