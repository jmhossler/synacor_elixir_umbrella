import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :synacor_elixir_web, SynacorChallengeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "8vh+fk7ruBKZNg0ggWuPydmL1fEkXhAIi6KjSlG+mgTFaMWduEuafqHOteMhTxZ/",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :synacor_elixir, SynacorChallenge.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
