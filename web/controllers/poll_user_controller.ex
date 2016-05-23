defmodule BaxterPoll.PollUserController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.PollUser
  alias BaxterPoll.User

  plug :scrub_params, "poll_user" when action in [:create, :update]

  def index(conn, _params) do
    query = from u in User, where: u.process = true
        poll_users = Repo.all(query)
    render(conn, "index.html", poll_users: poll_users)
  end

  def new(conn, _params) do
    changeset = PollUser.changeset(%PollUser{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll_user" => poll_user_params}) do
    changeset = PollUser.changeset(%PollUser{}, poll_user_params)

    case Repo.insert(changeset) do
      {:ok, _poll_user} ->
        conn
        |> put_flash(:info, "Poll user created successfully.")
        |> redirect(to: poll_user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll_user = Repo.get!(PollUser, id)
    render(conn, "show.html", poll_user: poll_user)
  end

  def edit(conn, %{"id" => id}) do
    poll_user = Repo.get!(PollUser, id)
    changeset = PollUser.changeset(poll_user)
    render(conn, "edit.html", poll_user: poll_user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll_user" => poll_user_params}) do
    poll_user = Repo.get!(PollUser, id)
    changeset = PollUser.changeset(poll_user, poll_user_params)

    case Repo.update(changeset) do
      {:ok, poll_user} ->
        conn
        |> put_flash(:info, "Poll user updated successfully.")
        |> redirect(to: poll_user_path(conn, :show, poll_user))
      {:error, changeset} ->
        render(conn, "edit.html", poll_user: poll_user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll_user = Repo.get!(PollUser, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(poll_user)

    conn
    |> put_flash(:info, "Poll user deleted successfully.")
    |> redirect(to: poll_user_path(conn, :index))
  end
end
