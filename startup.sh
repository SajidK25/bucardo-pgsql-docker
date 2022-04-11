#!/bin/bash
service postgresql start
echo "Starting Bucardo..."
su - postgres -c "bucardo start"
su - postgres -c "bucardo show all"
su - postgres -c "bucardo status"

echo "..........Bucardo Status........."
while true; do
    su - postgres -c "bucardo status"
    sleep 5s
done
