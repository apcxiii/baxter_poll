defmodule BaxterPoll.Repo.Migrations.CreatePollTopicAnswer do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:poll_topic_answers) do
      add :answer, :string
      add :poll_topic_id, references(:poll_topics, on_delete: :nothing)
      add :created_at, :datetime
      add :updated_at, :datetime
    end
    create index(:poll_topic_answers, [:poll_topic_id])

  end

  def down do
  	drop_if_exists table(:poll_topic_answers)
  end

end
