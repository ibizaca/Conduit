# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :conduit,
  ecto_repos: [Conduit.Repo]

# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hOsQgKhLqW4cH7OtrxE5riUepOKuQ/SCN2aBHnp/09+8mUN/3kvTyMqRI7nPvdA3",
  render_errors: [view: ConduitWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Conduit.PubSub,
           adapter: Phoenix.PubSub.PG2]

#Commanded application configuration to use EventStore adapter
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

#Commanded ecto projection configuration for ecto repo
config :commanded_ecto_projections,
  repo: Conduit.Repo

#Validator configuration for Vex
config :vex,
sources: [
  Conduit.Accounts.Validators,
  Conduit.Support.Validators,
  Vex.Validators
]

#Guardian configuration for authentication service using JWT token
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Conduit",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "Ho+FdG8AO8y6g0ZARIYDX8VS4XwyCpHa1HtM2/GFLtfBFg8Yn40ha+FTfLsX0X0E",
  serializer: Conduit.Auth.GuardianSerializer

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
