defmodule BaxterPoll.PollTopicControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.PollTopic
  @valid_attrs %{active: true, order: 42, text: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, poll_topic_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing poll topics"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, poll_topic_path(conn, :new)
    assert html_response(conn, 200) =~ "New poll topic"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, poll_topic_path(conn, :create), poll_topic: @valid_attrs
    assert redirected_to(conn) == poll_topic_path(conn, :index)
    assert Repo.get_by(PollTopic, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, poll_topic_path(conn, :create), poll_topic: @invalid_attrs
    assert html_response(conn, 200) =~ "New poll topic"
  end

  test "shows chosen resource", %{conn: conn} do
    poll_topic = Repo.insert! %PollTopic{}
    conn = get conn, poll_topic_path(conn, :show, poll_topic)
    assert html_response(conn, 200) =~ "Show poll topic"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, poll_topic_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    poll_topic = Repo.insert! %PollTopic{}
    conn = get conn, poll_topic_path(conn, :edit, poll_topic)
    assert html_response(conn, 200) =~ "Edit poll topic"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    poll_topic = Repo.insert! %PollTopic{}
    conn = put conn, poll_topic_path(conn, :update, poll_topic), poll_topic: @valid_attrs
    assert redirected_to(conn) == poll_topic_path(conn, :show, poll_topic)
    assert Repo.get_by(PollTopic, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    poll_topic = Repo.insert! %PollTopic{}
    conn = put conn, poll_topic_path(conn, :update, poll_topic), poll_topic: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit poll topic"
  end

  test "deletes chosen resource", %{conn: conn} do
    poll_topic = Repo.insert! %PollTopic{}
    conn = delete conn, poll_topic_path(conn, :delete, poll_topic)
    assert redirected_to(conn) == poll_topic_path(conn, :index)
    refute Repo.get(PollTopic, poll_topic.id)
  end
end
