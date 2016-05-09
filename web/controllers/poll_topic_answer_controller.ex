defmodule BaxterPoll.PollTopicAnswerController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.PollTopicAnswer

  plug :scrub_params, "poll_topic_answer" when action in [:create, :update]

  def index(conn, _params) do
    poll_topic_answers = Repo.all(PollTopicAnswer)
    render(conn, "index.html", poll_topic_answers: poll_topic_answers)
  end

  def new(conn, _params) do
    changeset = PollTopicAnswer.changeset(%PollTopicAnswer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll_topic_answer" => poll_topic_answer_params}) do
    changeset = PollTopicAnswer.changeset(%PollTopicAnswer{}, poll_topic_answer_params)

    case Repo.insert(changeset) do
      {:ok, _poll_topic_answer} ->
        conn
        |> put_flash(:info, "Poll topic answer created successfully.")
        |> redirect(to: poll_topic_answer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll_topic_answer = Repo.get!(PollTopicAnswer, id)
    render(conn, "show.html", poll_topic_answer: poll_topic_answer)
  end

  def edit(conn, %{"id" => id}) do
    poll_topic_answer = Repo.get!(PollTopicAnswer, id)
    changeset = PollTopicAnswer.changeset(poll_topic_answer)
    render(conn, "edit.html", poll_topic_answer: poll_topic_answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll_topic_answer" => poll_topic_answer_params}) do
    poll_topic_answer = Repo.get!(PollTopicAnswer, id)
    changeset = PollTopicAnswer.changeset(poll_topic_answer, poll_topic_answer_params)

    case Repo.update(changeset) do
      {:ok, poll_topic_answer} ->
        conn
        |> put_flash(:info, "Poll topic answer updated successfully.")
        |> redirect(to: poll_topic_answer_path(conn, :show, poll_topic_answer))
      {:error, changeset} ->
        render(conn, "edit.html", poll_topic_answer: poll_topic_answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll_topic_answer = Repo.get!(PollTopicAnswer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(poll_topic_answer)

    conn
    |> put_flash(:info, "Poll topic answer deleted successfully.")
    |> redirect(to: poll_topic_answer_path(conn, :index))
  end
end
