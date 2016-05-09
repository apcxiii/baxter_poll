defmodule BaxterPoll.PollTopicTypeTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.PollTopicType

  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PollTopicType.changeset(%PollTopicType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PollTopicType.changeset(%PollTopicType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
