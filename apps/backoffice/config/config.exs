import Config

# General application configuration
config :backoffice,
  namespace: MyApp.BackOffice,
  ecto_repos: [MyApp.Core.Repo]

# Configures the endpoint
config :backoffice, MyApp.BackOffice.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "murfQz1cDmVww7z4pHsRcCDp4JgAOwz1NBQQpr8NlSaBzqjZprdxyB8rorIKMs1D",
  render_errors: [view: MyApp.BackOffice.ErrorView, accepts: ~w(html json)],
  pubsub_server: MyApp.BackOffice.PubSub

config :phoenix, :json_library, Jason
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :backoffice, :generators, context_app: :core

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
