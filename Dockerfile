FROM amazonlinux

RUN yum update -y

RUN yum install httpd -y

WORKDIR /var/www/html

COPY ./index.html .

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80