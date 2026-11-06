# Disposable environment the verifier runs submissions in.
# Node 22 on Debian bookworm already carries git, python3 and build tools.
FROM node:22-bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends python3-pip python3-venv curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Run as an unprivileged user; submissions never get root.
RUN useradd --create-home --shell /bin/bash sandbox \
 && mkdir -p /work && chown sandbox:sandbox /work
USER sandbox
WORKDIR /work

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    npm_config_update_notifier=false

CMD ["sleep", "infinity"]
