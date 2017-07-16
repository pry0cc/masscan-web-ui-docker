#!/bin/bash

docker build -t pry0cc/masscan-web .
sudo docker run -d -p 5050:80 -v $(pwd)/scans:/app/scans --name masscan-web pry0cc/masscan-web
