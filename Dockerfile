FROM bitwalker/alpine-elixir:1.5.2

RUN apk --no-cache update && \
    apk add alpine-sdk nodejs nodejs-npm postgresql

RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=prod PORT=3000
EXPOSE 3000

ADD mix.exs mix.lock ./
RUN mix deps.get

ADD . ./
RUN MIX_ENV=prod mix compile

CMD ["mix", "phx.server"]
