# Stage 1: Builder
FROM golang:latest AS builder

ENV CGO_ENABLED=0
ENV GO111MODULE=off
ENV GOPATH=/app
ENV GOOS=linux

WORKDIR /app

COPY . .

RUN go install master server client

# Stage 2: Runner
FROM alpine:latest

WORKDIR /docker-bin
COPY --from=builder /app/bin/master .
COPY --from=builder /app/bin/server .
COPY --from=builder /app/bin/client .

WORKDIR /app

EXPOSE 7087 7070 7071 7072

CMD ["/docker-bin/master"]