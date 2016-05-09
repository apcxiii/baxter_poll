defmodule BaxterPoll.PollTopicTypeControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.PollTopicType
  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, poll_topic_type_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing poll topic type"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, poll_topic_type_path(conn, :new)
    assert html_response(conn, 200) =~ "New poll topic type"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, poll_topic_type_path(conn, :create), poll_topic_type: @valid_attrs
    assert redirected_to(conn) == poll_topic_type_path(conn, :index)
    assert Repo.get_by(PollTopicType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, poll_topic_type_path(conn, :create), poll_topic_type: @invalid_attrs
    assert html_response(conn, 200) =~ "New poll topic type"
  end

  test "shows chosen resource", %{conn: conn} do
    poll_topic_type = Repo.insert! %PollTopicType{}
    conn = get conn, poll_topic_type_path(conn, :show, poll_topic_type)
    assert html_response(conn, 200) =~ "Show poll topic type"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, poll_topic_type_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    poll_topic_type = Repo.insert! %PollTopicType{}
    conn = get conn, poll_topic_type_path(conn, :edit, poll_topic_type)
    assert html_response(conn, 200) =~ "Edit poll topic type"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    poll_topic_type = Repo.insert! %PollTopicType{}
    conn = put conn, poll_topic_type_path(conn, :update, poll_topic_type), poll_topic_type: @valid_attrs
    assert redirected_to(conn) == poll_topic_type_path(conn, :show, poll_topic_type)
    assert Repo.get_by(PollTopicType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    poll_topic_type = Repo.insert! %PollTopicType{}
    conn = put conn, poll_topic_type_path(conn, :update, poll_topic_type), poll_topic_type: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit poll topic type"
  end

  test "deletes chosen resource", %{conn: conn} do
    poll_topic_type = Repo.insert! %PollTopicType{}
    conn = delete conn, poll_topic_type_path(conn, :delete, poll_topic_type)
    assert redirected_to(conn) == poll_topic_type_path(conn, :index)
    refute Repo.get(PollTopicType, poll_topic_type.id)
  end
end
