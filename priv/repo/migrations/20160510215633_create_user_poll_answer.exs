defmodule BaxterPoll.Repo.Migrations.CreateUserPollAnswer do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:user_poll_answers) do
      add :answer, :string
      add :user_id, :integer
      add :poll_id, :integer
      add :poll_topic_id, :integer
      add :created_at, :datetime
      add :updated_at, :datetime
    end
  end
  def down do
    drop_if_exists table(:user_poll_answers)
  end
end
