FROM golang:1.23-bookworm@sha256:1a5326b07cbab12f4fd7800425f2cf25ff2bd62c404ef41b56cb99669a710a83 as builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 go build -v -o server

FROM gcr.io/distroless/static-debian12@sha256:4147d0aaf606da5a17bfb06678ead6a9b44bf39340e40a550b5ebc3b54f699c8
WORKDIR /app
COPY --from=builder /app/server /app/server
CMD ["/app/server"]