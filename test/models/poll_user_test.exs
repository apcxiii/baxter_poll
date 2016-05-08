defmodule BaxterPoll.PollUserTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.PollUser

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PollUser.changeset(%PollUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PollUser.changeset(%PollUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
