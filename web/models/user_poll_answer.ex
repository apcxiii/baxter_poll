defmodule BaxterPoll.UserPollAnswer do
  use BaxterPoll.Web, :model

  schema "user_poll_answers" do
    field :answer, :string, default: " "
    field :user_id, :integer
    field :poll_id, :integer
    field :poll_topic_id, :integer
    has_one :user, BaxterPoll.User, foreign_key: :id, references: :user_id
    has_one :poll, BaxterPoll.Poll, foreign_key: :id, references: :poll_id    
    has_one :poll_topic, BaxterPoll.PollTopic, foreign_key: :id, references: :poll_topic_id   
    
    timestamps([{:inserted_at,:created_at}])
  end

  @required_fields ~w(user_id poll_id poll_topic_id)
  @optional_fields ~w(answer)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
