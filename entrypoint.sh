#!/bin/sh
# Generates /etc/xray/config.json from environment variables at container start.
# Required: UUID (VLESS client id). Optional: WS_PATH (default /ws), PORT (default 8080).
set -e

: "${UUID:?UUID environment variable is required}"

WS_PATH="${WS_PATH:-/ws}"
PORT="${PORT:-8080}"

mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {"clients": [{"id": "$UUID"}], "decryption": "none"},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "$WS_PATH"}}
    }
  ],
  "outbounds": [{"protocol": "freedom"}]
}
EOF

exec /usr/local/bin/xray run -c /etc/xray/config.json
