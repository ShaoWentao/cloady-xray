# cloady-xray

xray (VLESS + WebSocket) node for the Cloady free tier (0.5 vCPU / 1 GB RAM).
TLS is terminated by the Cloady edge; the container serves plain WebSocket.

## Deploy

Deploy this repo as a Cloady app in region `usw1` (US West), environment
`production`. Set these environment variables in the app settings:

| Variable | Value |
| --- | --- |
| `UUID` | a fresh VLESS client UUID (generate one, never commit it) |
| `WS_PATH` | WebSocket path, e.g. `/ws-xxxxxxxx` |
| `PORT` | `8080` |

No secrets are stored in this repo. If the deploy card shows any price above
$0.00, or asks for a card, do not deploy.

## Client

`vless://<UUID>@<app-hostname>:443?encryption=none&security=tls&sni=<app-hostname>&type=ws&host=<app-hostname>&path=%2F<ws-path>#Cloady-US`
