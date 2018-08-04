FROM bitwalker/alpine-elixir:1.7.1

RUN apk --no-cache update && \
    apk add alpine-sdk nodejs nodejs-npm postgresql

RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=prod PORT=3000
EXPOSE 3000

ADD mix.exs mix.lock ./
RUN mix deps.get

ADD . ./
RUN mix compile

CMD ["mix", "phx.server"]
