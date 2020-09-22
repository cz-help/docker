#!/bin/sh

start_timestamp=$(date +%s)

while [ "$(curl -s http://${1}/midpoint/actuator/health | grep status | sed "s/.*\"status\":\"\([^\"]*\).*/\1/")" != "UP" \
	-o $(( $(date +%s) - ${start_timestamp} )) -gt ${3:-300} ]
do
	echo "${1} is not yet up / wait for ${1} to start... ( $(( $(date +%s) - ${start_timestamp} )) s)"
	sleep 3
done
${2}
