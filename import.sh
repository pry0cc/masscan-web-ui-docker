#!/bin/bash

while true; do f=$(ls /app/scans/scanned/*.xml | head -n 1); if [[ -f $f ]]; then php /app/nocheck.php $f; mv $f "/app/scans/done/"; else sleep 1; fi; done
