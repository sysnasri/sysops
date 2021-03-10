FROM mysql:5.7
RUN apt-get update && apt-get upgrade -y
ENV MYSQL_ROOT_PASSWORD: 123456
ENV MYSQL_DATABASE: wp_test
ENV MYSQL_USERNAME: wpuser
ENV MYSQL_PASSWORD: wppassword

COPY ./wp_test.sql /root/wp_test.sql
RUN mysql -u root -p$MYSQL_ROOT_PASSWORD  -e "GRANT ALL PRIVILEGES ON wp_test.* TO 'wpuser'@'%' IDENTIFIED BY 'wppassword';FLUSH PRIVILEGES;" && \
     mysql -u root -p${MYSQL_ROOT_PASSWORD}  < /root/wp_test.sql
EXPOSE 3306
