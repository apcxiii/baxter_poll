defmodule BaxterPoll.PollTopicAnswer do
  use BaxterPoll.Web, :model

  schema "poll_topic_answers" do
    field :answer, :string
    belongs_to :poll_topic, BaxterPoll.PollTopic
    timestamps([{:inserted_at,:created_at}])
  end

  @required_fields ~w(answer)
  @optional_fields ~w()

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
