#!/bin/bash
service postgresql start
echo "Starting Bucardo..."
su - postgres -c "bucardo start"
while true; do
    su - postgres -c "bucardo status"
    sleep 5s
done