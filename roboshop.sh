#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID= "sg-01ba20ec749c1a0dc" # replace with your SG ID

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-01ba20ec749c1a0dc --tag-specifications "ResourceType=instance,Tags=[{key=Name,Value=$instance}]" --query 'Instance[0].InstanceId' --output text)

    # Get Private IP
    if [ $instance != "fronted" ]; then
        IP=$(aws ec2 describe-instances --instance-ids i-0d19a7ed8b21fd56f --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids i-0d19a7ed8b21fd56f --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

    if

    echo "$instance: $IP"
done