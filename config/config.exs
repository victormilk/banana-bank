# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :banana_bank,
  ecto_repos: [BananaBank.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :banana_bank, BananaBankWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: BananaBankWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BananaBank.PubSub,
  live_view: [signing_salt: "FnTsfSHY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, disable_deprecated_builder_warning: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
