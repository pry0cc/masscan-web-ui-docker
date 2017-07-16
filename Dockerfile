FROM tutum/lamp:latest

RUN rm -fr /app && git clone https://github.com/offensive-security/masscan-web-ui.git /app
COPY config.php /app/config.php
COPY create_mysql_admin_user.sh /create_mysql_admin_user.sh
EXPOSE 80 3306
CMD ["/run.sh"]
