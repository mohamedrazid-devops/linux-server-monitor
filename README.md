# Linux Server Monitoring & Alert System

## Overview

Linux Server Monitoring & Alert System is a Bash-based monitoring project
that checks important Linux system resources and services.

## Features

- Displays current user and hostname
- Monitors CPU usage
- Monitors RAM usage
- Monitors disk usage
- Checks CPU, RAM and disk warning thresholds
- Monitors SSH service
- Monitors Cron service
- Displays top CPU-consuming processes
- Displays top memory-consuming processes
- Stores monitoring output in a log file
- Runs automatically using Cron

## Technologies Used

- Linux
- Bash Shell Scripting
- systemctl
- top
- free
- df
- ps
- awk
- grep
- bc
- Cron

## Project Structure

linux-server-monitor/
├── monitor.sh
├── monitor.log
└── README.md

## How to Run

Make the script executable:

chmod +x monitor.sh

Run the monitoring script:

./monitor.sh

## Logging

Monitoring output can be stored in monitor.log:

./monitor.sh >> monitor.log 2>&1

View the latest logs:

tail monitor.log

## Cron Automation

The script is configured to run automatically every 2 minutes.

Cron entry:

*/2 * * * * /home/razid/linux-server-monitor/monitor.sh >> /home/razid/linux-server-monitor/monitor.log 2>&1

## Monitoring Thresholds

CPU usage >= 80%  → Warning
RAM usage >= 80%  → Warning
Disk usage >= 80% → Warning

## Project Goal

The goal of this project is to understand Linux system monitoring,
Bash scripting, process monitoring, service monitoring, logging,
and task automation using Cron.
