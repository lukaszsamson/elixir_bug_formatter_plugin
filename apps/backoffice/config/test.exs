import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :backoffice, MyApp.BackOffice.Endpoint,
  http: [port: 4001],
  server: false

config :backoffice, :known_proxies, 2
