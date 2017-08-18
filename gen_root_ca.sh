#!/bin/bash

# Criando a pasta do CA
mkdir ca

# Gerando a chave privada
sudo openssl genrsa -out ca/rootCA.key 2048

# Gerando o certificado
sudo openssl req -x509 -new -nodes -key ca/rootCA.key -sha256 -days 1024 -out ca/rootCA.pem 

# Convertendo o PEM para CRT
openssl x509 -outform der -in ca/rootCA.pem -out ca/rootCA.crt

printf "\nRoot CA Criado!\n\n"
