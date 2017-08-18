# Gerando um certificado de desenvolvimento com openssl sem o problema [missing_subjectAltName] do Chrome 58+

```bash
eyscudeler@ubuntu:~/ssl$ sudo chmod 777 gen_root_ca.sh
eyscudeler@ubuntu:~/ssl$ ./gen_root_ca.sh
Generating RSA private key, 2048 bit long modulus
.............................+++
................................................................................+++
e is 65537 (0x10001)
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:BR
State or Province Name (full name) [Some-State]:Sao Paulo
Locality Name (eg, city) []:Sao Bernardo do Campo
Organization Name (eg, company) [Internet Widgits Pty Ltd]:EYScudeler
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:Erik Yeger Scudeler
Email Address []:contato@eyscudeler.com.br

Root CA Criado!

eyscudeler@ubuntu:~/ssl$
```

```bash
eyscudeler@ubuntu:~/ssl$ ./gen_certificate.sh www.eyscudeler.com.br
Gerando certificado para o domínio www.eyscudeler.com.br
Generating a 2048 bit RSA private key
...........+++
......................................+++
unable to write 'random state'
writing new private key to 'www.eyscudeler.com.br/private.key'
-----
Getting request Private Key
Generating certificate request
unable to write 'random state'
Signature ok
subject=/C=BR/ST=Sao Paulo/L=Sao Bernardo do Campo/O=EYScudeler/emailAddress=contato@eyscudeler.com.br/CN=www.eyscudeler.com.br
Getting CA Private Key
unable to write 'random state'
unable to write 'random state'
eyscudeler@ubuntu:~/ssl$
```
