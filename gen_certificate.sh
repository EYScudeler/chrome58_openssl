#!/bin/bash

# Domínio
FQDN="$1"

printf "Gerando certificado para o domínio ${FQDN}\n"

# Criando a pasta do domínio
mkdir -p "${FQDN}"

# Criando o arquivo de configuração
cp openssl.cnf ${FQDN}/
printf "CN=${FQDN}\n" >> ${FQDN}/openssl.cnf
printf "\n[${FQDN}]\n" >> ${FQDN}/openssl.cnf
printf "subjectAltName=DNS:${FQDN}\n" >> ${FQDN}/openssl.cnf

# Criando o CSR
openssl req -newkey rsa:2048 \
  -x509 \
  -nodes \
  -keyout ${FQDN}/private.key \
  -new \
  -out ${FQDN}/request.csr \
  -subj /CN=${FQDN} \
  -reqexts ${FQDN} \
  -extensions ${FQDN} \
  -config ${FQDN}/openssl.cnf \
  -sha256 \
  -days 3650

# Convertendo o CSR para REQ
openssl x509 \
  -x509toreq \
  -days 365 \
  -in ${FQDN}/request.csr \
  -signkey ${FQDN}/private.key \
  -out ${FQDN}/request.req

# Criando o arquivo v3
printf "authorityKeyIdentifier=keyid,issuer\n" > ${FQDN}/v3.ext
printf "basicConstraints=CA:FALSE\n" >> ${FQDN}/v3.ext
printf "keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\n" >> ${FQDN}/v3.ext
printf "subjectAltName = @alt_names\n" >> ${FQDN}/v3.ext
printf "\n" >> ${FQDN}/v3.ext
printf "[alt_names]\n" >> ${FQDN}/v3.ext
printf "DNS.1 = ${FQDN}\n" >> ${FQDN}/v3.ext

# Gerando o certificado
openssl x509 \
  -req \
  -in ${FQDN}/request.req \
  -CA ca/rootCA.pem \
  -CAkey ca/rootCA.key \
  -CAcreateserial \
  -out ${FQDN}/certificate.crt \
  -days 500 \
  -sha256 \
  -extfile ${FQDN}/v3.ext

# Exportando o certificado e a chave em PKCS#12 (Arquivo PFX)
openssl pkcs12 \
  -export \
  -out ${FQDN}/certificate.pfx \
  -inkey ${FQDN}/private.key \
  -in ${FQDN}/certificate.crt \
  -password pass:

# Criando uma pasta de exportação com os arquivos necessários
mkdir -p ${FQDN}/export

cp ca/rootCA.crt ${FQDN}/export/
cp ${FQDN}/certificate.pfx ${FQDN}/export/
cp ${FQDN}/certificate.crt ${FQDN}/export/




