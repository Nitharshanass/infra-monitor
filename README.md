# infra-monitor
Simple infrastructure monitoring dashboard
# Infrastructure Monitor

![Status](https://img.shields.io/badge/status-monitoring-brightgreen)

This repo automatically monitors website uptime every 15 minutes using GitHub Actions — no server required.

## What it monitors
- Portfolio Website
- Google  
- My API

## How it works
1. A GitHub Actions workflow runs every 15 minutes
2. It pings each target URL and records UP/DOWN status + response time
3. Results are logged to `status_log.csv`
4. This README badge reflects the latest overall status
