#!/bin/bash

mkdir -p scans/scanned
mkdir -p scans/done
mkdir -p scans/config
cp exclude.txt scans/
cp scan.sh scans/
docker run -d -p 5050:80 -v $(pwd)/scans:/app/scans --name masscan-web pry0cc/masscan-web
