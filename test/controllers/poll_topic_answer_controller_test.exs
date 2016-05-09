defmodule BaxterPoll.PollTopicAnswerControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.PollTopicAnswer
  @valid_attrs %{answer: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, poll_topic_answer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing poll topic answers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, poll_topic_answer_path(conn, :new)
    assert html_response(conn, 200) =~ "New poll topic answer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, poll_topic_answer_path(conn, :create), poll_topic_answer: @valid_attrs
    assert redirected_to(conn) == poll_topic_answer_path(conn, :index)
    assert Repo.get_by(PollTopicAnswer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, poll_topic_answer_path(conn, :create), poll_topic_answer: @invalid_attrs
    assert html_response(conn, 200) =~ "New poll topic answer"
  end

  test "shows chosen resource", %{conn: conn} do
    poll_topic_answer = Repo.insert! %PollTopicAnswer{}
    conn = get conn, poll_topic_answer_path(conn, :show, poll_topic_answer)
    assert html_response(conn, 200) =~ "Show poll topic answer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, poll_topic_answer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    poll_topic_answer = Repo.insert! %PollTopicAnswer{}
    conn = get conn, poll_topic_answer_path(conn, :edit, poll_topic_answer)
    assert html_response(conn, 200) =~ "Edit poll topic answer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    poll_topic_answer = Repo.insert! %PollTopicAnswer{}
    conn = put conn, poll_topic_answer_path(conn, :update, poll_topic_answer), poll_topic_answer: @valid_attrs
    assert redirected_to(conn) == poll_topic_answer_path(conn, :show, poll_topic_answer)
    assert Repo.get_by(PollTopicAnswer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    poll_topic_answer = Repo.insert! %PollTopicAnswer{}
    conn = put conn, poll_topic_answer_path(conn, :update, poll_topic_answer), poll_topic_answer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit poll topic answer"
  end

  test "deletes chosen resource", %{conn: conn} do
    poll_topic_answer = Repo.insert! %PollTopicAnswer{}
    conn = delete conn, poll_topic_answer_path(conn, :delete, poll_topic_answer)
    assert redirected_to(conn) == poll_topic_answer_path(conn, :index)
    refute Repo.get(PollTopicAnswer, poll_topic_answer.id)
  end
end
