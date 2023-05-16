FROM --platform=$BUILDPLATFORM golang:1.20.4-alpine3.18 as build
RUN apk add git make
WORKDIR /app
ARG XRAY_VERSION=v1.8.1
ARG TARGETOS
ARG TARGETARCH
RUN git clone https://github.com/XTLS/Xray-core -b ${XRAY_VERSION} && \
    cd Xray-core && env GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o reality -trimpath -ldflags "-s -w -buildid=" ./main
RUN go install github.com/subfuzion/envtpl/cmd/envtpl@latest

FROM alpine:3.18
COPY --from=build /app/Xray-core/reality /bin/reality
COPY --from=build /go/bin/envtpl /bin/envtpl
WORKDIR /app
ADD https://github.com/v2fly/geoip/releases/latest/download/geoip.dat /bin/geoip.dat
ADD https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat /bin/geosite.dat
ADD ./config.yaml.tpl config.yaml.tpl
ADD ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 7890
