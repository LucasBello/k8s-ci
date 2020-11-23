#!/bin/bash
mkdir ~/.kube
mv ./build-scripts/kubeconfig ~/.kube/config
 
#decrypt the large secrets
{Your openssl command from the encrypt secrets stage here}
 
# run the script to get the secrets as environment variables
source ./build-scripts/large-secrets.txt
export $(cut -d= -f1 ./build-scripts/large-secrets.txt)
 
 
# Set kubernetes secrets
./kubectl config set clusters.cl.com.br.certificate-authority-data $CERTIFICATE_AUTHORITY_DATA
./kubectl config set users.cl.com.br.client-certificate-data "$CLIENT_CERTIFICATE_DATA"
./kubectl config set users.cl.com.br.client-key-data "$CLIENT_KEY_DATA"
./kubectl config set users.cl.com.br.password "$KUBE_PASSWORD"
./kubectl config set users.cl.com.br.net-basic-auth.password "$KUBE_PASSWORD"
 
# set AWS secrets
mkdir ~/.aws
touch ~/.aws/credentials
echo '[default]' >> ~/.aws/credentials
echo "aws_access_key_id = $AWS_KEY">> ~/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_KEY" >> ~/.aws/credentials
 
# set AWS region
touch ~/.aws/config
echo '[default]' >> ~/.aws/config
echo "output = json">> ~/.aws/config
echo "region = sa-east-1" >> ~/.aws/config
