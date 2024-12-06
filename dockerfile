# Base image
FROM ubuntu:jammy

# Install dependencies
RUN apt update && apt install -y \
    supervisor curl wget unzip \
    && rm -rf /var/lib/apt/lists/*
# Install Sing-Box
RUN VERSION=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest \
    | grep tag_name \
    | cut -d ":" -f2 \
    | sed 's/\"//g;s/\,//g;s/\ //g;s/v//') && \
curl -Lo sing-box.deb "https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box_${VERSION}_linux_amd64.deb" && \
dpkg -i sing-box.deb && \
rm sing-box.deb
# Install Warp-Plus
RUN WARP_VERSION=$(curl -s https://api.github.com/repos/bepass-org/warp-plus/releases/latest \
    | grep tag_name \
    | cut -d ":" -f2 \
    | sed 's/\"//g;s/\,//g;s/\ //g;s/v//') && \
curl -Lo warp-plus_linux-amd64.zip "https://github.com/bepass-org/warp-plus/releases/download/v${WARP_VERSION}/warp-plus_linux-amd64.zip" && \
unzip warp-plus_linux-amd64.zip && \
rm "README.md" "LICENSE" "warp-plus_linux-amd64.zip" && \
mv warp-plus /usr/bin/

# Copy Singbox and supervisord.conf
COPY singwarp/singwarp.conf /etc/supervisor/conf.d/singwarp.conf
COPY singwarp/config.json /root/config.json

# Start supervisor
CMD ["/usr/bin/supervisord", "-n"]
