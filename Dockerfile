FROM docker:29.2.1

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --update python3 py3-pip coreutils bash \
  && rm -rf /var/cache/apk/* \
  && python3 -m venv /opt/venv \
  && /opt/venv/bin/pip install --no-cache-dir pyyaml==5.3.1 \
  && /opt/venv/bin/pip install --no-cache-dir -U awscli \
  && apk --purge -v del py3-pip

ADD entrypoint.sh /entrypoint.sh

ENV PATH="/opt/venv/bin:${PATH}"

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
