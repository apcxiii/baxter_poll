defmodule BaxterPoll.UserPollAnswerController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.UserPollAnswer
  alias BaxterPoll.PollTopic

  plug :scrub_params, "user_poll_answer" when action in [:create, :update]

  def index(conn, _params) do
    user_poll_answers = Repo.all(UserPollAnswer)
    render(conn, "index.html", user_poll_answers: user_poll_answers)
  end

  def index_user(conn, %{"user_id" => user_id}) do
    
    query = from u in UserPollAnswer, where: u.user_id == ^user_id, preload: [:poll_topic], order_by: [asc: u.id]
    user_poll_answers = Repo.all(query)
    render(conn, "index.html", user_poll_answers: user_poll_answers)
  end

  def new(conn, _params) do
    changeset = UserPollAnswer.changeset(%UserPollAnswer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_poll_answer" => user_poll_answer_params}) do
    changeset = UserPollAnswer.changeset(%UserPollAnswer{}, user_poll_answer_params)

    case Repo.insert(changeset) do
      {:ok, _user_poll_answer} ->
        conn
        |> put_flash(:info, "User poll answer created successfully.")
        |> redirect(to: user_poll_answer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_poll_answer = Repo.get!(UserPollAnswer, id)
    render(conn, "show.html", user_poll_answer: user_poll_answer)
  end

  def edit(conn, %{"id" => id}) do
    query = from a in UserPollAnswer, where: a.id == ^id, preload: [poll_topic: :poll_topic_type]
    user_poll_answer = Repo.one query
    changeset = UserPollAnswer.changeset(user_poll_answer)
    render(conn, "edit.html", user_poll_answer: user_poll_answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_poll_answer" => user_poll_answer_params}) do
    user_poll_answer = Repo.get!(UserPollAnswer, id)
    changeset = UserPollAnswer.changeset(user_poll_answer, user_poll_answer_params)

    case Repo.update(changeset) do
      {:ok, user_poll_answer} ->
        conn
        |> put_flash(:info, "User poll answer updated successfully.")
        |> redirect(to: user_poll_answer_path(conn, :index_user, user_poll_answer.user_id))
      {:error, changeset} ->
        render(conn, "edit.html", user_poll_answer: user_poll_answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_poll_answer = Repo.get!(UserPollAnswer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_poll_answer)

    conn
    |> put_flash(:info, "User poll answer deleted successfully.")
    |> redirect(to: user_poll_answer_path(conn, :index))
  end
end
