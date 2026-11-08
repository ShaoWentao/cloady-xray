# syntax=docker/dockerfile:1
# Multi-stage build: the official xray image is distroless (no shell),
# so copy only its binary into Alpine and run it from our own entrypoint.
FROM ghcr.io/xtls/xray-core:v26.3.27 AS xray

FROM alpine:3.21
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
