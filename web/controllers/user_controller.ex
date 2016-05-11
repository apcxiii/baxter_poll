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
    users = Repo.all(User)
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
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        polls = get_polls
        render(conn, "new.html", changeset: changeset, polls: polls)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do    
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
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
end
