#!/bin/bash
set -e

# Run init scripts (credits go to MySQL Docker entrypoint script)
for f in ${HOME_DIR}/docker/init_* ${HOME_DIR}/docker/init.d/*; do
      case "$f" in
        *.sh)  echo "[Entrypoint] running $f"; . "$f" ;;
        *)     echo "[Entrypoint] ignoring $f" ;;
      esac
      echo
done

# NOTE: Sourcing the conf/startup.properties file did not work on
#       alpine with ash or bash. Reason unclear. Replaced by env vars
#       from Docker (which does make more sense anyway).

# setup the classpath
CP=.$(find -L "$LIB_DIR" -type d -exec printf ":{}/*" \;)
export CLASSPATH=$CP

# build the java options string
JAVA_OPTS=${JAVA_OPTS}" -Dlog4j.configurationFile=file://${CONF_DIR}/log4j2.xml"
JAVA_OPTS=${JAVA_OPTS}" -Djava.awt.headless=true -DCONF=${CONF_DIR} -DSTATE=${STATE_DIR}"

# build up the cmdline
RUN_COMMAND="java ${JAVA_OPTS} pl.edu.icm.unity.engine.server.UnityApplication ${PARAM}"

# run it! (and replace shell with java process)
exec ${RUN_COMMAND}
