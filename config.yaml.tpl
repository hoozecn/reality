log:
  loglevel: warn
inbounds:
  - port: {{.HTTP_PORT}}
    listen: 0.0.0.0
    protocol: http
    settings:
      timeout: 300
      allowTransparent: false
      userLevel: 0
outbounds:
  - protocol: vless
    settings:
      vnext:
        - port: {{.SERVER_PORT}}
          address: {{.SERVER_HOST}}
          users:
            - id: {{.VLESS_ID}}
              flow: xtls-rprx-vision
              encryption: none
    streamSettings:
      network: tcp
      security: reality
      realitySettings:
        fingerprint: safari
        serverName: {{.REALITY_SERVER_NAME}}
        publicKey: {{.REALITY_PUBLIC_KEY}}
        shortId: {{.REALITY_SHORT_ID}}
        spiderX: "/"
  - protocol: freedom
    settings: {}
    tag: direct
routing:
  domainStrategy: IPOnDemand
  rules:
    - type: field
      domain:
        - geosite:cn
      ip:
        - geoip:private
        - geoip:cn
      outboundTag: direct
dns:
  servers:
    - 8.8.8.8
    - localhost
