import Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :backoffice, MyApp.BackOffice.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [npm: ["run", "start", cd: Path.expand("../assets", __DIR__)]]

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
# Watch static and templates for browser reloading.
config :backoffice, MyApp.BackOffice.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/backoffice/(live|views)/.*(ex)$",
      ~r"lib/backoffice/templates/.*(eex)$"
    ]
  ]
