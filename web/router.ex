

defmodule BaxterPoll.Router do
  use BaxterPoll.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BaxterPoll do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    addict :routes

    resources "/users", UserController
    resources "/polls", PollController
    resources "/poll_users", PollUserController
    resources "/poll_topics", PollTopicController
    resources "/poll_topic_types", PollTopicTypeController
    resources "/poll_topic_answers", PollTopicAnswerController
    resources "/user_questionaries", UserQuestionaryController
    resources "/user_poll_answers", UserPollAnswerController
    get "/user_poll_answers/index/:user_id", UserPollAnswerController, :index_user
  end

  # Other scopes may use custom stacks.
  # scope "/api", BaxterPoll do
  #   pipe_through :api
  # end
end
