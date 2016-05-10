defmodule BaxterPoll.UserQuestionaryController do
  use BaxterPoll.Web, :controller

  alias BaxterPoll.UserQuestionary

  plug :scrub_params, "user_questionary" when action in [:create, :update]

  def index(conn, _params) do
    user_questionaries = []
    render(conn, "index.html", user_questionaries: user_questionaries)
  end

  # def new(conn, _params) do
  #   changeset = UserQuestionary.changeset(%UserQuestionary{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"user_questionary" => user_questionary_params}) do
  #   changeset = UserQuestionary.changeset(%UserQuestionary{}, user_questionary_params)

  #   case Repo.insert(changeset) do
  #     {:ok, _user_questionary} ->
  #       conn
  #       |> put_flash(:info, "User questionary created successfully.")
  #       |> redirect(to: user_questionary_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   user_questionary = Repo.get!(UserQuestionary, id)
  #   render(conn, "show.html", user_questionary: user_questionary)
  # end

  # def edit(conn, %{"id" => id}) do
  #   user_questionary = Repo.get!(UserQuestionary, id)
  #   changeset = UserQuestionary.changeset(user_questionary)
  #   render(conn, "edit.html", user_questionary: user_questionary, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "user_questionary" => user_questionary_params}) do
  #   user_questionary = Repo.get!(UserQuestionary, id)
  #   changeset = UserQuestionary.changeset(user_questionary, user_questionary_params)

  #   case Repo.update(changeset) do
  #     {:ok, user_questionary} ->
  #       conn
  #       |> put_flash(:info, "User questionary updated successfully.")
  #       |> redirect(to: user_questionary_path(conn, :show, user_questionary))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", user_questionary: user_questionary, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user_questionary = Repo.get!(UserQuestionary, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(user_questionary)

  #   conn
  #   |> put_flash(:info, "User questionary deleted successfully.")
  #   |> redirect(to: user_questionary_path(conn, :index))
  # end
end
