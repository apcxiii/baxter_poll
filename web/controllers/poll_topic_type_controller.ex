defmodule BaxterPoll.PollTopicTypeController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.PollTopicType

  plug :scrub_params, "poll_topic_type" when action in [:create, :update]

  def index(conn, _params) do
    poll_topic_type = Repo.all(PollTopicType)
    render(conn, "index.html", poll_topic_type: poll_topic_type)
  end

  def new(conn, _params) do
    changeset = PollTopicType.changeset(%PollTopicType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll_topic_type" => poll_topic_type_params}) do
    changeset = PollTopicType.changeset(%PollTopicType{}, poll_topic_type_params)

    case Repo.insert(changeset) do
      {:ok, _poll_topic_type} ->
        conn
        |> put_flash(:info, "Poll topic type created successfully.")
        |> redirect(to: poll_topic_type_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll_topic_type = Repo.get!(PollTopicType, id)
    render(conn, "show.html", poll_topic_type: poll_topic_type)
  end

  def edit(conn, %{"id" => id}) do
    poll_topic_type = Repo.get!(PollTopicType, id)
    changeset = PollTopicType.changeset(poll_topic_type)
    render(conn, "edit.html", poll_topic_type: poll_topic_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll_topic_type" => poll_topic_type_params}) do
    poll_topic_type = Repo.get!(PollTopicType, id)
    changeset = PollTopicType.changeset(poll_topic_type, poll_topic_type_params)

    case Repo.update(changeset) do
      {:ok, poll_topic_type} ->
        conn
        |> put_flash(:info, "Poll topic type updated successfully.")
        |> redirect(to: poll_topic_type_path(conn, :show, poll_topic_type))
      {:error, changeset} ->
        render(conn, "edit.html", poll_topic_type: poll_topic_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll_topic_type = Repo.get!(PollTopicType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(poll_topic_type)

    conn
    |> put_flash(:info, "Poll topic type deleted successfully.")
    |> redirect(to: poll_topic_type_path(conn, :index))
  end
end
