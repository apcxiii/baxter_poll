defmodule BaxterPoll.PollTopicController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.PollTopic

  plug :scrub_params, "poll_topic" when action in [:create, :update]

  def index(conn, _params) do
    query = from t in PollTopic, preload: [:poll_topic_type]
    poll_topics = Repo.all(query)
    render(conn, "index.html", poll_topics: poll_topics)
  end

  def new(conn, _params) do
    changeset = PollTopic.changeset(%PollTopic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll_topic" => poll_topic_params}) do
    changeset = PollTopic.changeset(%PollTopic{}, poll_topic_params)

    case Repo.insert(changeset) do
      {:ok, _poll_topic} ->
        conn
        |> put_flash(:info, "Poll topic created successfully.")
        |> redirect(to: poll_topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll_topic = Repo.get!(PollTopic, id)
    render(conn, "show.html", poll_topic: poll_topic)
  end

  def edit(conn, %{"id" => id}) do
    poll_topic = Repo.get!(PollTopic, id)
    changeset = PollTopic.changeset(poll_topic)
    render(conn, "edit.html", poll_topic: poll_topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll_topic" => poll_topic_params}) do
    poll_topic = Repo.get!(PollTopic, id)
    changeset = PollTopic.changeset(poll_topic, poll_topic_params)

    case Repo.update(changeset) do
      {:ok, poll_topic} ->
        conn
        |> put_flash(:info, "Poll topic updated successfully.")
        |> redirect(to: poll_topic_path(conn, :show, poll_topic))
      {:error, changeset} ->
        render(conn, "edit.html", poll_topic: poll_topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll_topic = Repo.get!(PollTopic, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(poll_topic)

    conn
    |> put_flash(:info, "Poll topic deleted successfully.")
    |> redirect(to: poll_topic_path(conn, :index))
  end
end
