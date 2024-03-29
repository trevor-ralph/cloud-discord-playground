FROM golang:1.12 AS builder

WORKDIR /build
COPY ./src .

RUN go get -d -v github.com/bwmarrin/discordgo
RUN CGO_ENABLED=0 GOOS=linux go build -v -o discord-bot

FROM alpine:3.9.4
RUN apk add --no-cache ca-certificates

COPY --from=builder /build/discord-bot /discord-bot
RUN chmod +x /discord-bot
CMD ["/discord-bot"]