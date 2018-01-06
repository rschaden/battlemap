# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :battlemap,
  ecto_repos: [Battlemap.Repo]

# Configures the endpoint
config :battlemap, BattlemapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TRI3Mmw1bI/br92xPI3oduSik5Uubx9ZVO+JZXpwKCG6vUViT4Mfnbu9ow8ay21p",
  render_errors: [view: BattlemapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Battlemap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
