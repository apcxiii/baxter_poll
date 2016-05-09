defmodule BaxterPoll.Repo.Migrations.CreatePollUser do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:poll_users) do
      add :user_id, references(:users, on_delete: :nothing)
      add :poll_id, references(:polls, on_delete: :nothing)
      add :created_at, :datetime
      add :updated_at, :datetime
    end
    create index(:poll_users, [:user_id])
    create index(:poll_users, [:poll_id])

  end

  def down do
    drop_if_exists table(:poll_users)
  end

end
