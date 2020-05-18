FROM golang:1.14.2 AS builder

WORKDIR /go/src/github.com/chennqqi/http-dump

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build --ldflags "-s -w" -a -installsuffix cgo -o http-dump .

FROM scratch

COPY --from=0 /go/src/github.com/chennqqi/http-dump/http-dump .

EXPOSE 8080

CMD ["./http-dump"]
