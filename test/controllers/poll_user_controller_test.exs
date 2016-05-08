defmodule BaxterPoll.PollUserControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.PollUser
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, poll_user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing poll users"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, poll_user_path(conn, :new)
    assert html_response(conn, 200) =~ "New poll user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, poll_user_path(conn, :create), poll_user: @valid_attrs
    assert redirected_to(conn) == poll_user_path(conn, :index)
    assert Repo.get_by(PollUser, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, poll_user_path(conn, :create), poll_user: @invalid_attrs
    assert html_response(conn, 200) =~ "New poll user"
  end

  test "shows chosen resource", %{conn: conn} do
    poll_user = Repo.insert! %PollUser{}
    conn = get conn, poll_user_path(conn, :show, poll_user)
    assert html_response(conn, 200) =~ "Show poll user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, poll_user_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    poll_user = Repo.insert! %PollUser{}
    conn = get conn, poll_user_path(conn, :edit, poll_user)
    assert html_response(conn, 200) =~ "Edit poll user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    poll_user = Repo.insert! %PollUser{}
    conn = put conn, poll_user_path(conn, :update, poll_user), poll_user: @valid_attrs
    assert redirected_to(conn) == poll_user_path(conn, :show, poll_user)
    assert Repo.get_by(PollUser, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    poll_user = Repo.insert! %PollUser{}
    conn = put conn, poll_user_path(conn, :update, poll_user), poll_user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit poll user"
  end

  test "deletes chosen resource", %{conn: conn} do
    poll_user = Repo.insert! %PollUser{}
    conn = delete conn, poll_user_path(conn, :delete, poll_user)
    assert redirected_to(conn) == poll_user_path(conn, :index)
    refute Repo.get(PollUser, poll_user.id)
  end
end
