defmodule BaxterPoll.Repo.Migrations.CreatePollTopic do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:poll_topics) do
      add :text, :string
      add :active, :boolean, default: false
      add :order, :integer
      add :poll_id, references(:polls, on_delete: :nothing)
      add :created_at, :datetime
      add :updated_at, :datetime
    end
    create index(:poll_topics, [:poll_id])

  end

  def down do
    drop_if_exists table(:poll_topics)
  end
end
