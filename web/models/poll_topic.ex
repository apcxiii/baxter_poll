defmodule BaxterPoll.PollTopic do
  use BaxterPoll.Web, :model

  schema "poll_topics" do
    field :text, :string
    field :active, :boolean, default: false
    field :order, :integer    
    field :poll_topic_type_id, :integer
    has_one :poll_topic_type, BaxterPoll.PollTopicType, foreign_key: :id, references: :poll_topic_type_id    
    belongs_to :poll, BaxterPoll.Poll,foreign_key: :poll_id    
    timestamps([{:inserted_at,:created_at}])
  end

  @required_fields ~w(text poll_id active order poll_topic_type_id)
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
