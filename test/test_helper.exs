ExUnit.start

Mix.Task.run "ecto.create", ~w(-r BaxterPoll.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r BaxterPoll.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(BaxterPoll.Repo)

