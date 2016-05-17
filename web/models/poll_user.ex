defmodule BaxterPoll.PollUser do
  use BaxterPoll.Web, :model

  schema "poll_users" do

    belongs_to :user, BaxterPoll.User, foreign_key: :user_id
    belongs_to :poll, BaxterPoll.Poll, foreign_key: :poll_id
    timestamps([{:inserted_at,:created_at}])
  end

  @required_fields ~w(user_id poll_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:poll_id)
  end
end
