FROM alpine:latest
MAINTAINER Shawn Hwei <shawn@shawnh.net>

ARG timezone=UTC

RUN apk update && apk upgrade

RUN apk add --no-cache samba samba-common-tools supervisor tzdata

RUN cp /usr/share/zoneinfo/$timezone /etc/localtime && echo "$timezone" > /etc/timezone && date && apk del tzdata

COPY *.conf /

RUN mkdir /share

VOLUME /share

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["supervisord", "-c", "/supervisord.conf"]
