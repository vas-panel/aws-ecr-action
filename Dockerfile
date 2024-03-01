FROM docker:19.03.4

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update python3 py3-pip coreutils bash \
    && rm -rf /var/cache/apk/* \
    # Install specific Python 3 packages.
    && pip3 install pyyaml==5.3.1 \
    && pip3 install -U awscli \
    # Clean up to keep the image small.
    && apk --purge -v del py3-pip

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
