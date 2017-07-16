FROM tutum/lamp:latest

RUN rm -fr /app && git clone https://github.com/offensive-security/masscan-web-ui.git /app
COPY config.php /app/config.php
COPY create_mysql_admin_user.sh /create_mysql_admin_user.sh
COPY nocheck.php /app/nocheck.php
COPY import.sh /import.sh
COPY supervisord-import.conf /etc/supervisor/conf.d/supervisord-import.conf

COPY run.sh /run.sh
COPY config /app/config
COPY scan.sh /app/scan.sh
COPY exclude.txt /app/exclude.txt

EXPOSE 80 3306
CMD ["/run.sh"]
