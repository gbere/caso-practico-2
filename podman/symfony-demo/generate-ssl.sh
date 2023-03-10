#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SSL_DIR="${SCRIPT_DIR}/ssl/private/"

# Generar certificados
openssl genrsa -out ${SSL_DIR}sf-demo.key 2048
openssl req -key ${SSL_DIR}sf-demo.key -new -out ${SSL_DIR}sf-demo.csr -subj "/C=ES/ST=Lleida/L=Lleida/O=DevOps/OU=Ejemplo/CN=vm1"
openssl x509 -signkey ${SSL_DIR}sf-demo.key -in ${SSL_DIR}sf-demo.csr -req -days 365 -out ${SSL_DIR}sf-demo.crt

openssl dhparam -out ${SSL_DIR}dh2048.pem 2048
