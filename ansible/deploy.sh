#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Instalamos las collections adicionales, en caso de no tenerlas instaladas
ansible-galaxy collection install containers.podman
ansible-galaxy collection install community.crypto

# Ejecuta playbook playbook-vm1.yaml usando la clave privada ssh ~/.ssh/id_rsa_cp2
ansible-playbook -i $SCRIPT_DIR/hosts.yaml $SCRIPT_DIR/playbook-vm1.yaml --private-key ~/.ssh/id_rsa_cp2

ansible-playbook -i $SCRIPT_DIR/hosts.yaml $SCRIPT_DIR/playbook-aks1.yaml
