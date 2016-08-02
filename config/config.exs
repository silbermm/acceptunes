# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :acceptunes, Acceptunes.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "m3AlXBJsRDs6edv0cW1UaAmNiY/ZqnV6T3qRL1U/a1EbJWF6IMePfxkzEdXo6nhb",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Acceptunes.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :acceptunes,
  rally_api_key: System.get_env("RALLY_API_KEY"),
  rally_workspace_id: System.get_env("RALLY_WORKSPACE_ID"),
  rally_project_id: 27593501023,
  current_timezone: "America/New_York",
  asound_location: "/usr/bin/alsaplayer",
  asound_options: [ "-i", "text" ]

config :quantum, cron: [
  # Every minute
  "* * * * *": {Acceptunes.Scheduler, :run}
]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false