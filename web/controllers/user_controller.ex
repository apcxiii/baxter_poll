defmodule BaxterPoll.UserController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.User
  alias BaxterPoll.Poll
  alias BaxterPoll.PollTopic
  alias BaxterPoll.PollTopicType
  alias BaxterPoll.UserPollAnswer

  require Logger

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    query = from u in User, where: u.process == true
    users = Repo.all(query)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do        
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)    
    case Repo.insert(changeset) do
      {:ok, _user} ->
        Logger.info "_user = #{inspect _user}"
        make_answers(_user.id)
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show,_user))
      {:error, changeset} ->
        polls = get_polls
        render(conn, "new.html", changeset: changeset, polls: polls)
    end
  end

  def show(conn, %{"id" => id}) do
    query_poll_topics = from t in PollTopic, preload: [:poll_topic_type], order_by: [asc: t.order]
    query_user = from u in User, where: u.id == ^id, preload: [user_poll_answers: [:poll, :poll_topic]]
    user = Repo.one!(query_user)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do    
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def user_poll(conn, _params) do
    Logger.info "edit_not_process function"
    query_poll_topics = from t in PollTopic, preload: [:poll_topic_type], order_by: [asc: t.order]
    query = from u in User, where: u.process == false, preload: [user_poll_answers: :poll_topic], limit: 1 
    user = Repo.one!(query)
    topics = Repo.all(query_poll_topics)    
    changeset = User.changeset(user)
    render(conn, "user_poll.html", user: user, changeset: changeset, topics: topics)
  end

  def update_user_poll(conn, %{"id" => id, "user" => user_params}) do
    
    query_poll_topics = from t in PollTopic, preload: [:poll_topic_type], order_by: [asc: t.order]
    topics = Repo.all(query_poll_topics)    
    user = Repo.get!(User, id)
    
    Logger.info "user_params = #{inspect user_params}"
    changeset = User.changeset(user, %{name: Map.get(user_params, "name", nil),
                                        email: Map.get(user_params, "email", nil),
                                        first_last_name: Map.get(user_params, "first_last_name", nil),
                                        second_last_name: Map.get(user_params, "second_last_name", nil),
                                        area: Map.get(user_params, "area", nil),
                                        process: true,
                                        id: id})
    Logger.info "changeset.user = #{inspect changeset}"
    answers = Map.get(user_params, "user_poll_answers", nil) 
    Enum.each(0..9, fn(index) -> 
      answer = Map.get(answers,"#{inspect index}", nil)
      query_answer = from ua in UserPollAnswer, where: ua.user_id == ^id and ua.poll_topic_id == ^(index + 1)

       changeset = UserPollAnswer.changeset(Repo.one!(query_answer), %{user_id: id,
         poll_id: 1, answer: Map.get(answer, "answer", nil), poll_topic_id: index + 1})
       Logger.info "update_user_poll.changeset = #{inspect changeset}"
       update_answer(changeset)
    end)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "user_poll.html", user: user, changeset: changeset,topics: topics)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp get_polls do
    query_poll_topics = from t in PollTopic, preload: [:poll_topic_type], order_by: [asc: t.order]
    query_poll = from p in Poll, where: p.id == 1, preload: [poll_topics: ^query_poll_topics]
    polls = Repo.all query_poll
  end

  defp make_answers(user_id) do

    poll_topics = Repo.all(PollTopic)
    changesets = Enum.map(poll_topics, fn topic -> 
      Logger.info "topic = #{inspect topic}"
      UserPollAnswer.changeset(%UserPollAnswer{},%{user_id: user_id, poll_id: 1, poll_topic_id: topic.id})
    end)

    Enum.each(changesets, fn changeset ->      
      Logger.info "changeset = #{inspect changeset}"
       case Repo.insert(changeset) do
      {:ok, _user_poll_answer} ->
        Logger.info "_user_poll_answer = #{inspect _user_poll_answer}"        
      {:error, changeset} ->
        Logger.error "ERROR ====> #{inspect changeset}"
    end
    end)
  end

  defp update_answer(changeset) do

    case Repo.update(changeset) do
       {:ok, ans} ->
         Logger.info "ans = #{inspect ans}"
       {:error, changeset} ->
         Logger.error "changeset = #{inspect changeset}"
    end
  end
end
