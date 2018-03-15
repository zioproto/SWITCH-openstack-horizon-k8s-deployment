#!/bin/bash

TLSKEY=key.pem
TLSCERT=cert.pem

USERNAME=username
SECRET=secret
EMAIL=saverio.proto@switch.ch
SERVER=cr.gitlab.switch.ch

kubectl create secret tls horizonsecret \
  --key $TLSKEY\
  --cert $TLSCERT

kubectl create secret docker-registry gitlabswitch \
  --docker-server=$SERVER \
  --docker-username=$USERNAME \
  --docker-password=$SECRET \
  --docker-email=$EMAIL

kubectl create secret generic horizonsecretkey \
  --from-file=.secret_key_store=<(openssl rand -base64 64)

