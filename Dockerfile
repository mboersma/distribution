FROM alpine:3.1

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV GOPATH /go:$DISTRIBUTION_DIR/Godeps/_workspace

WORKDIR $DISTRIBUTION_DIR
COPY . $DISTRIBUTION_DIR

RUN apk add -U go make \
    && make binaries \
    && cp bin/* /usr/local/bin/ \
    && cp -r cmd /usr/local/share/ \
    && rm -rf /go \
    && apk del --purge go make

EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["/usr/local/share/cmd/registry/config.yml"]
