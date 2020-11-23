#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0;0m'
export PATH=$PATH:$(pwd)
echo -e "${GREEN}==== Deploying RBAC role ====${NC}"
cd ../rbac/
for f in $(find ./ -name '*.yaml' -or -name '*.yml'); do kubectl apply -f $f --validate=false; done
echo -e "${GREEN}==== Done deploying RBAC role ====${NC}"
echo ''
echo -e "${GREEN}==== Deploying iam role ====${NC}"
cd ../kube2iam/
for f in $(find ./ -name '*.yaml' -or -name '*.yml'); do kubectl apply -f $f --validate=false; done
echo -e "${GREEN}==== Done deploying iam role ====${NC}"
echo ''
echo -e "${GREEN}==== Deploying external dns ====${NC}"
cd ../external_dns/
for f in $(find ./ -name '*.yaml' -or -name '*.yml'); do kubectl apply -f $f --validate=false; done
echo -e "${GREEN}==== Done deploying external dns ====${NC}"
echo ''
echo -e "${GREEN}==== Deploying apps ====${NC}"
 
for d in ../apps/ ; do
    
    for f in $(find $d -name '*.yaml' -or -name '*.yml');
    do
        echo -e "${GREEN}==== Deploying ${f} ====${NC}"
        kubectl apply -f $f --validate=false;
        echo -e "${GREEN}==== Done Deploying ${f} ====${NC}"
    done
done
 
echo -e "${GREEN}==== Done deploying apps ====${NC}"
echo ''
