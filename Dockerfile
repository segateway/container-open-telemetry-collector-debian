
FROM debian:bookworm-slim
ARG TARGETARCH
ARG TARGETPLATFORM
ARG OTEL_BUILD=0.87.0
ARG OTEL_PACKAGE="otelcol"
RUN cd /tmp;\
    apt update -y;\
    apt install -y systemd wget; \
    wget "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTEL_BUILD}/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb" ;\
    apt install -y /tmp/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb ;\
    apt-get clean autoclean

ENTRYPOINT ["otelcol"]