#!/bin/bash

cd /app/

while true; do f=$(ls scans/scanned/*.xml | head -n 1); if [[ -f $f ]]; then php nocheck.php $f; mv $f "scans/done/"; else sleep 1; fi; done
