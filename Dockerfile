FROM alpine:3.9
# Define software versions.
ARG JAVAJRE_VERSION=8.212.04.2
ARG TMM_VERSION=3.0.2

# Define software download URLs.
ARG TMM_URL=https://release.tinymediamanager.org/v3/dist/tmm_${TMM_VERSION}_linux.tar.gz
ARG JAVAJRE_URL=https://d3pxv6yz143wms.cloudfront.net/${JAVAJRE_VERSION}/amazon-corretto-${JAVAJRE_VERSION}-linux-x64.tar.gz

# Define working directory.
WORKDIR /tmp

# Download TinyMediaManager
RUN \
    mkdir -p /defaults && \
    wget ${TMM_URL} -O /defaults/tmm.tar.gz

# Download and install Oracle JRE.
# NOTE: This is needed only for the 7-Zip-JBinding workaround.
RUN \
    add-pkg --virtual build-dependencies curl && \
    mkdir /opt/jre && \
    curl -# -L ${JAVAJRE_URL} | tar -xz --strip 2 -C /opt/jre amazon-corretto-${JAVAJRE_VERSION}-linux-x64/jre && \
    del-pkg build-dependencies

# Install dependencies.
RUN \
    add-pkg \
        # For the 7-Zip-JBinding workaround, Oracle JRE is needed instead of
        # the Alpine Linux's openjdk native package.
        # The libstdc++ package is also needed as part of the 7-Zip-JBinding
        # workaround.
        #openjdk8-jre \
        libmediainfo \
        ttf-dejavu

# Add files.
COPY rootfs/ /

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/media"]


RUN apk add --no-cache gettext docker

COPY ./entrypoint.sh /mnt/entrypoint.sh

RUN chmod +x /mnt/entrypoint.sh

ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "0"] 

# Metadata.
LABEL \
      org.label-schema.name="tinymediamanager" \
      org.label-schema.description="Docker container for TinyMediaManager" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/romancin/tmm-docker" \
      org.label-schema.schema-version="1.0"
