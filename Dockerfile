FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive TERM=xterm-256color
RUN apt update && apt install -yq --no-install-recommends ca-certificates wget unzip file && \
    wget -q "https://github.com/thijsvos/torrentTUI/releases/download/v0.20.0/torrenttui-linux-x86_64" -O /usr/local/bin/torrent && chmod +x /usr/local/bin/torrent && \
    wget "https://github.com/sxyazi/yazi/releases/download/v26.9.1/yazi-x86_64-unknown-linux-gnu.deb" -O /tmp/yazi.deb && \
    apt install -yq /tmp/yazi.deb && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY bash.bashrc /etc/bash.bashrc
COPY profile /etc/profile

WORKDIR /downloads
ENTRYPOINT ["/bin/sh", "-c", "torrent --headless -d /downloads && exec sleep infinity"]
