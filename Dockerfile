
FROM debian:bookworm-slim
ARG TARGETARCH
ARG TARGETPLATFORM
ARG OTEL_BUILD=0.87.0
ARG OTEL_PACKAGE="otelcol"
# hadolint ignore=DL3008
RUN apt-get update -y;\
    apt-get install -y --no-install-recommends systemd wget; \ 
    wget -q -O /tmp/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTEL_BUILD}/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb" ;\
    apt-get install -y --no-install-recommends /tmp/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb ;\
    apt-get clean ;\
    rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["otelcol"]