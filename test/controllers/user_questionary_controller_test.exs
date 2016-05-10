defmodule BaxterPoll.UserQuestionaryControllerTest do
  use BaxterPoll.ConnCase

  alias BaxterPoll.UserQuestionary
  @valid_attrs %{area: "some content", email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_questionary_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user questionaries"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_questionary_path(conn, :new)
    assert html_response(conn, 200) =~ "New user questionary"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_questionary_path(conn, :create), user_questionary: @valid_attrs
    assert redirected_to(conn) == user_questionary_path(conn, :index)
    assert Repo.get_by(UserQuestionary, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_questionary_path(conn, :create), user_questionary: @invalid_attrs
    assert html_response(conn, 200) =~ "New user questionary"
  end

  test "shows chosen resource", %{conn: conn} do
    user_questionary = Repo.insert! %UserQuestionary{}
    conn = get conn, user_questionary_path(conn, :show, user_questionary)
    assert html_response(conn, 200) =~ "Show user questionary"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_questionary_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_questionary = Repo.insert! %UserQuestionary{}
    conn = get conn, user_questionary_path(conn, :edit, user_questionary)
    assert html_response(conn, 200) =~ "Edit user questionary"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_questionary = Repo.insert! %UserQuestionary{}
    conn = put conn, user_questionary_path(conn, :update, user_questionary), user_questionary: @valid_attrs
    assert redirected_to(conn) == user_questionary_path(conn, :show, user_questionary)
    assert Repo.get_by(UserQuestionary, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_questionary = Repo.insert! %UserQuestionary{}
    conn = put conn, user_questionary_path(conn, :update, user_questionary), user_questionary: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user questionary"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_questionary = Repo.insert! %UserQuestionary{}
    conn = delete conn, user_questionary_path(conn, :delete, user_questionary)
    assert redirected_to(conn) == user_questionary_path(conn, :index)
    refute Repo.get(UserQuestionary, user_questionary.id)
  end
end
