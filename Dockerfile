
FROM golang:alpine AS builder
RUN apk --update add ca-certificates
WORKDIR /app
COPY . ./
RUN go mod tidy -diff
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-w -s" -o gatus .

FROM scratch
COPY --from=builder /app/gatus .
COPY --from=builder /app/config.yaml ./config/config.yaml
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ENV GATUS_CONFIG_PATH="./config/config.yaml"
ENV GATUS_LOG_LEVEL="INFO"
ENV PORT="8080"
EXPOSE 8080
USER 65534:65534
ENTRYPOINT ["/gatus"]
