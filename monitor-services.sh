#!/bin/bash

# Dependencies: msmtp

to="user@domain.com"
subject_down="Service Down Alert"
subject_recovered="Service Recovered Alert"
subject_failed="Service Failed Alert"
instance="debian"
msmtprc="/home/user/.msmtprc"
services=("service 1" "service 2")

for service in "${services[@]}"; do
    if ! systemctl is-active --quiet "$service"; then
        echo -e "To: $to\r\nSubject: $subject_down\r\n\r\nThe service \"$service\" is down on \"$instance\" instance." | msmtp -C "$msmtprc" -t "$to"
        systemctl restart "$service"

        if systemctl is-active --quiet "$service"; then
            echo -e "To: $to\r\nSubject: $subject_recovered\r\n\r\nThe service \"$service\" is recovered on \"$instance\" instance." | msmtp -C "$msmtprc" -t "$to"
        else
            echo -e "To: $to\r\nSubject: $subject_failed\r\n\r\nThe service \"$service\" is failed on \"$instance\" instance." | msmtp -C "$msmtprc" -t "$to"
        fi
    fi
done
