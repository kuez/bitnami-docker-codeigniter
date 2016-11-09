FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r3

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=che-codeigniter \
    BITNAMI_IMAGE_VERSION=che-3.1.0-r7 \
    PATH=/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Install CodeIgniter dependencies
RUN bitnami-pkg install php-7.0.11-1 --checksum cc9129523269e86728eb81ac489c65996214f22c6447bbff4c2306ec4be3c871
RUN bitnami-pkg install mysql-client-10.1.19-0 --checksum 0415602d69cb7e8c05d721267cf953b97228aa055d3f2e0c90de3a2f00192f21
RUN bitnami-pkg install mariadb-10.1.19-0 --checksum c54e3fdc689cdd2f2119914e4f255722f96f1d7fef37a064fd46fb84b013da7b

# Install CodeIgniter module
RUN bitnami-pkg install codeigniter-3.1.0-2 --checksum 00f4e413b46969bc31e1df5db8a54814eb1b221c30da7e8ec4911ac69b41d33c -- --applicationDirectory /projects

EXPOSE 8000

# Set up Codenvy integration
LABEL che:server:8000:ref=codeigniter che:server:8000:protocol=http

USER bitnami
WORKDIR /projects

ENV TERM=xterm

CMD [ "sudo", "HOME=/root", "/opt/bitnami/nami/bin/nami", "start", "--foreground", "mariadb"]
