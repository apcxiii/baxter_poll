defmodule BaxterPoll.UserPollAnswerControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.UserPollAnswer
  @valid_attrs %{ansewr: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_poll_answer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user poll answers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_poll_answer_path(conn, :new)
    assert html_response(conn, 200) =~ "New user poll answer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_poll_answer_path(conn, :create), user_poll_answer: @valid_attrs
    assert redirected_to(conn) == user_poll_answer_path(conn, :index)
    assert Repo.get_by(UserPollAnswer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_poll_answer_path(conn, :create), user_poll_answer: @invalid_attrs
    assert html_response(conn, 200) =~ "New user poll answer"
  end

  test "shows chosen resource", %{conn: conn} do
    user_poll_answer = Repo.insert! %UserPollAnswer{}
    conn = get conn, user_poll_answer_path(conn, :show, user_poll_answer)
    assert html_response(conn, 200) =~ "Show user poll answer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_poll_answer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_poll_answer = Repo.insert! %UserPollAnswer{}
    conn = get conn, user_poll_answer_path(conn, :edit, user_poll_answer)
    assert html_response(conn, 200) =~ "Edit user poll answer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_poll_answer = Repo.insert! %UserPollAnswer{}
    conn = put conn, user_poll_answer_path(conn, :update, user_poll_answer), user_poll_answer: @valid_attrs
    assert redirected_to(conn) == user_poll_answer_path(conn, :show, user_poll_answer)
    assert Repo.get_by(UserPollAnswer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_poll_answer = Repo.insert! %UserPollAnswer{}
    conn = put conn, user_poll_answer_path(conn, :update, user_poll_answer), user_poll_answer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user poll answer"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_poll_answer = Repo.insert! %UserPollAnswer{}
    conn = delete conn, user_poll_answer_path(conn, :delete, user_poll_answer)
    assert redirected_to(conn) == user_poll_answer_path(conn, :index)
    refute Repo.get(UserPollAnswer, user_poll_answer.id)
  end
end
