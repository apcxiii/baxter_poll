defmodule BaxterPoll.PollTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.Poll

  @valid_attrs %{active: true, description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Poll.changeset(%Poll{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Poll.changeset(%Poll{}, @invalid_attrs)
    refute changeset.valid?
  end
end
