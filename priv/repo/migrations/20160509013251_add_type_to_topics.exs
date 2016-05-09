defmodule BaxterPoll.Repo.Migrations.AddTypeToTopics do
  use Ecto.Migration

def up do
	alter table(:poll_topics) do
    add :poll_topic_type_id, :integer
  end
end

def down do
	alter table(:poll_topics) do
      remove :poll_topic_type_id
    end
end
  
end
