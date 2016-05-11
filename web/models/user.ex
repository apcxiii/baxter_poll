defmodule BaxterPoll.User do
  use BaxterPoll.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :first_last_name, :string
    field :second_last_name, :string
    field :name, :string
    field :area, :string
    has_many :poll_users, BaxterPoll.PollUser
    has_many :polls, through: [:poll_users, :poll]
    has_many :user_poll_answers, BaxterPoll.UserPollAnswer
    timestamps([{:inserted_at,:created_at}])
  end

  @required_fields ~w(email name first_last_name second_last_name area)
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
