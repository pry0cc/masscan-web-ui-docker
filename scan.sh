for f in $(ls config | grep $1); do masscan -c config/$f; mv $(cat config/$f | grep output-filename | awk '{ print $3 }')  scanned/; done
