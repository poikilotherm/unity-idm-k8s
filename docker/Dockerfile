FROM azul/zulu-openjdk-alpine:8

ARG UNITY_VERSION=2.8.2
ARG UNITY_SHA1=f16c58effff708d37a75002d8bd331b3203f1c0c
ARG UNITY_PKG=https://sourceforge.net/projects/unity-idm/files/Unity%20server/${UNITY_VERSION}/unity-server-distribution-${UNITY_VERSION}-dist.tar.gz/download

ENV BASE_DIR=/opt/unity
ENV CONF_DIR=${BASE_DIR}/conf\
    LIB_DIR=${BASE_DIR}/lib\
    STATE_DIR=${BASE_DIR}\
    JAVA_OPTS=""\
    PATH="${PATH}:${BASE_DIR}/bin"

# 1a) Install krallin/tini - a very tiny init system handling what JDK will not handle.
# 1b) Add real tar, too, to have stripping support
# 1c) Add bash to make use of upstream scripts written for bash
RUN apk add --no-cache tini tar bash

# 2) Create and set the Unity IDM user and working directory owned by the new user
RUN addgroup --gid 1000 unity && \
    adduser --uid 1000 --disabled-password --gecos "" --home ${BASE_DIR} --ingroup unity --shell /bin/bash --no-create-home unity && \
    echo unity:unity | chpasswd && \
    mkdir -p ${BASE_DIR}/docker && \
    chown -R unity: ${BASE_DIR}

# 3) From here on run as user unity
USER unity
WORKDIR ${BASE_DIR}

# 4) Download the release tar ball, do checksum, extract and cleanup
RUN wget -q --no-verbose -O unity-idm.tar.gz ${UNITY_PKG} && \
    echo "${UNITY_SHA1} *unity-idm.tar.gz" | sha1sum -c - && \
    tar -xzf unity-idm.tar.gz -C ${BASE_DIR} --strip-components=1 && \
    rm unity-idm.tar.gz

# Copy across docker scripts
COPY --chown=unity:unity bin/*.sh ${BASE_DIR}/docker
RUN mkdir -p ${BASE_DIR}/docker/init.d && \
    chmod +x ${BASE_DIR}/docker/*

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["docker/entrypoint.sh"]
