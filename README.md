Unir - Caso Practico 2
======================

[![license](https://img.shields.io/github/license/mashape/apistatus.svg?longCache=true&style=for-the-badge)](https://en.wikipedia.org/wiki/MIT_License)

## Objetivos

- Crear infraestructura de forma automatizada en un proveedor de Cloud pública.
- Utilizar herramientas de gestión de la configuración para automatizar la instalación y configuración de servicios.
- Desplegar mediante un enfoque totalmente automatizado aplicaciones en forma de contenedor sobre el sistema operativo.
- Desplegar mediante un enfoque totalmente automatizado aplicaciones que hagan uso de almacenamiento persistente sobre una plataforma de orquestación de contenedores.

## Requerimientos del nodo de control
- OS like UNIX
- python 3
- openssl
- podman
- az cli
- terraform cli

## Pasos a seguir para el despliegue
```bash
# Primero de todo nos tenemos que identificar en nuestra cuenta de azure
az login

# Desplegamos la infraestructura con Terraform y los playbooks de Ansible
./deploy.sh

# Cuando termine la script, podrá ver las siguientes instrucciones:
En breve se podra visitar:

    - La máquina virtual de linux con el app symfony demo
        -> URL: https:\\xxx.xxx.xxx.xxx\ 
        -> Zona segura: Entrar en backend y usar el usario administrador

    - El cluster AKS con adminer y mysql 
        -> URL: http:\\xxx.xxx.xxx.xxx\ 
        -> Servidor: mysql 
        -> Usuario: root o unir 
        -> Contraseña: unir 
        -> Base de datos: unir 
```
