#!/bin/bash
set -e

# Ensure we’re root here
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Get GID of the host Docker socket
if [ -S /var/run/docker.sock ]; then
  HOST_DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

  # If group with that GID doesn't exist, create it
  if ! getent group ${HOST_DOCKER_GID} >/dev/null; then
    groupadd -for -g ${HOST_DOCKER_GID} docker
  fi

  # Add jenkins user to that group
  usermod -aG ${HOST_DOCKER_GID} jenkins
fi

# Drop privileges to jenkins and start Jenkins
exec su -s /bin/bash jenkins -c "/usr/bin/tini -- /usr/local/bin/jenkins.sh $@"

