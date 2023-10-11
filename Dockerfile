
FROM debian:bookworm-slim

ARG TARGETARCH
ARG TARGETPLATFORM
ARG OTEL_BUILD=0.87.0
ARG OTEL_PACKAGE="otelcol"
ARG PACKAGES=base

COPY packages /work
# hadolint ignore=DL3015,DL3008,SC2046
RUN apt-get update -y;\
    apt-get install -y wget ca-certificates; \ 
    wget -q -O "/tmp/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb" "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTEL_BUILD}/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb" ;\
    apt-get install -y --no-install-recommends "/tmp/${OTEL_PACKAGE}_${OTEL_BUILD}_linux_${TARGETARCH}.deb" $(cat /work/${PACKAGES}.list);\
    apt-get remove -y wget;\
    apt-get autoremove -y ;\
    apt-get clean ;\
    rm -rf /var/lib/apt/lists/* ; rm -rf /tmp/*
# hadolint ignore=DL3002
USER root
ENTRYPOINT ["otelcol"]

