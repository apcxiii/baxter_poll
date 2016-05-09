defmodule BaxterPoll.Repo.Migrations.CreatePollTopicType do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:poll_topic_types) do
      add :description, :string
      add :created_at, :datetime
      add :updated_at, :datetime
    end

  end

  def down do
  	drop_if_exists table(:poll_topic_types)
  end
end
