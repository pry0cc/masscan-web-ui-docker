#!/bin/bash

docker build -t pry0cc/masscan-web .
mkdir -p scans/scanned
mkdir -p scans/done
cp -r config scans/
cp exclude.txt scans/
cp scan.sh scans/
docker run -d -p 5050:80 -v $(pwd)/scans:/app/scans --name masscan-web pry0cc/masscan-web
