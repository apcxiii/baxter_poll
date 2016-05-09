defmodule BaxterPoll.PollTopicAnswerTest do
  use BaxterPoll.ModelCase

  alias BaxterPoll.PollTopicAnswer

  @valid_attrs %{answer: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PollTopicAnswer.changeset(%PollTopicAnswer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PollTopicAnswer.changeset(%PollTopicAnswer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
