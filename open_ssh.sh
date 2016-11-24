#!/bin/bash

group=$1
source=$2

if [ -z $2 ]; then
    echo "$0 group-to-change source-group-pattern"
    exit 1
fi
source_group=`aws ec2 describe-security-groups --filter Name=group-name,Values=$source | grep GroupName | cut -d"\"" -f4`

echo "Allowing access to $group from $odd_group"

aws ec2 authorize-security-group-ingress --group-name $group --protocol tcp --port 22 --source-group $source_group
