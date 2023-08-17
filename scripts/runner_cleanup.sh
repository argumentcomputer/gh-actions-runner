#!/bin/bash

# Run this script frequently depending on runner usage
# Document downtime and pick a low-traffic time
# Example cron job every day:
# 0 0 * * * ./runner_cleanup.sh

# Remove all runner workdirs older than 1 day
find /var/tmp/runner/_work/ -mindepth 1 -maxdepth 1 -type d -ctime +1 -exec rm -r {} \;
