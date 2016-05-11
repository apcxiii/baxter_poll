defmodule BaxterPoll.UserPollAnswerTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.UserPollAnswer

  @valid_attrs %{ansewr: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserPollAnswer.changeset(%UserPollAnswer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserPollAnswer.changeset(%UserPollAnswer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
