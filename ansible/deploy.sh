#!/usr/bin/env bash

ansible-galaxy collection install containers.podman

# Ejecuta playbook playbook-vm1.yaml usando la clave privada ssh ~/.ssh/id_rsa_cp2
ansible-playbook -i hosts.yaml playbook-vm1.yaml --private-key ~/.ssh/id_rsa_cp2
