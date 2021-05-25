#######
# Compile Go App
#######

FROM golang:1.14-alpine AS builder

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /go/src/app
COPY ./services/app .

RUN go get -u github.com/pilu/fresh && go build -o run_app


#######
# Exec Binary file
#######

FROM scratch

EXPOSE 8000

COPY --from=builder /go/src/app/run_app /run_app

CMD ["./run_app"]
