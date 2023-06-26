FROM ghcr.io/penguincloud/core:v5.0.1 AS BUILD
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# PUT YER ARGS in here
ARG APP_TITLE="MongoDbCluster" # Change this to actual title for Default
ARG MONGODB_GPGKEY="https://www.mongodb.org/static/pgp/server-6.0.asc"
ARG MONGODB_VERSION="6.0"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV MONGODB_ADMIN="someone"
ENV MONGODB_ADMIN_PASSWORD="p@ssword"
ENV REPLICA_SET_NAME="ptg_replica"

# Switch to non-root user
USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
