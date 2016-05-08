# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :baxter_poll, BaxterPoll.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "B63yMtZmODQii/d+AY+qavlifXlLfGMTuyVsVdPGyRZH8kvnQWsqCcaJJDhNPZU1",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: BaxterPoll.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :addict,
  secret_key: "243262243132244f696861784d51346e61525252554e5a487755397975",
  extra_validation: fn ({valid, errors}, user_params) -> {valid, errors} end, # define extra validation here
  user_schema: BaxterPoll.User,
  repo: BaxterPoll.Repo,
  from_email: "no-reply@example.com", # CHANGE THIS
  mailgun_domain: "https://api.mailgun.net/v3/sandboxef0fb6e96a494b8dba94a9efce5fca5f.mailgun.org",
  mailgun_key: "key-7dfa7240cea618fba92f6e71ac8e319b",
  mail_service: :mailgun
