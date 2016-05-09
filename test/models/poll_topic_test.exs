defmodule BaxterPoll.PollTopicTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.PollTopic

  @valid_attrs %{active: true, order: 42, text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PollTopic.changeset(%PollTopic{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PollTopic.changeset(%PollTopic{}, @invalid_attrs)
    refute changeset.valid?
  end
end
