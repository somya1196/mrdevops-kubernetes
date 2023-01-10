FROM centos:latest
RUN yum install -y httpd
ADD https://www.free-css.com/assets/files/free-css-templates/download/pages254/photogenic.zip /var/www/html
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
EXPOSE 80
