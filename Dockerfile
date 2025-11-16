FROM debian:bullseye AS builder

RUN apt-get update && apt-get install -y \
    build-essential devscripts debhelper cssmin lcdf-typetools \
    node-less node-source-map uglifyjs pandoc xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

ADD http://security.debian.org/debian-security/pool/updates/main/t/twitter-bootstrap3/twitter-bootstrap3_3.4.1+dfsg-2+deb11u2.dsc ./
ADD http://security.debian.org/debian-security/pool/updates/main/t/twitter-bootstrap3/twitter-bootstrap3_3.4.1+dfsg-2+deb11u2.debian.tar.xz ./
ADD http://security.debian.org/debian-security/pool/updates/main/t/twitter-bootstrap3/twitter-bootstrap3_3.4.1+dfsg.orig.tar.xz ./

RUN mkdir -p src && \
    cd src && \
    dpkg-source -x ../twitter-bootstrap3_3.4.1+dfsg-2+deb11u2.dsc twitter-bootstrap3-3.4.1+dfsg && \
    cd twitter-bootstrap3-3.4.1+dfsg && \
    debuild -us -uc -b

# FIXED: Copy from bootstrap/ (not dist/)
RUN mkdir -p /build/extracted /build/dist && \
    find /build -name "*.deb" -exec dpkg-deb -x {} /build/extracted \; && \
    cp -r /build/extracted/usr/share/javascript/bootstrap/* /build/dist/

FROM busybox
COPY --from=builder /build/dist /dist
CMD ["cp", "-r", "/dist", "/output"]