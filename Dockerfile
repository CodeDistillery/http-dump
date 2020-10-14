FROM golang:1.15-alpine AS builder

WORKDIR /go/src/github.com/tislaamo/http-dump

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build --ldflags "-s -w" -a -installsuffix cgo -o http-dump .

FROM scratch

COPY --from=builder /go/src/github.com/tislaamo/http-dump/http-dump .

EXPOSE 8080

CMD ["./http-dump"]
