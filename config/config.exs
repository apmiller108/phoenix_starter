# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_starter,
  ecto_repos: [PhoenixStarter.Repo]

# Configures the endpoint
config :phoenix_starter, PhoenixStarter.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U7n7jnVH20jS5t7DUuatcbA8nkkwIf44drnWE0D80zTWSMyi9qebJa+0sUmfEeoJ",
  render_errors: [view: PhoenixStarter.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixStarter.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configures guardian
config :guardian, Guardian,
  allowed_algos: ["ES512"],
  verify_module: Guardian.JWT,
  issuer: "Founders",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: fn -> JOSE.JWK.from_file('secret_key.json') end,
  serializer: PhoenixStarter.GuardianSerializer
