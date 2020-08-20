FROM thothbot/alpine-jdk8

LABEL "repository"="https://github.com/mule-lint/github-action"
LABEL "homepage"="https://github.com/mule-lint/github-action"
LABEL "maintainer"="Chad Gorshing <gorshing@gmail.com>"

RUN apk --update add git less openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN git clone https://github.com/mule-lint/mule-lint.git /mule-lint-build

WORKDIR /mule-lint-build

RUN ./gradlew build

RUN mkdir -p /mule-lint && \
    cp /mule-lint-build/build/libs/mule-lint-*-all.jar /mule-lint/ && \
    rm -rf /mule-lint-build

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
