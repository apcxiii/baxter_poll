# defmodule Mix.Tasks.BaxterPoll.Seed do  
#   use Mix.Task
#   alias BaxterPoll.Repo
#   require Logger

#   def run(_) do
#     Mix.Task.run "app.start", []
#     seed(Mix.env)
#   end

#   def seed(:dev) do
#     # Any data for development goes here
#     # i.e. Repo.insert!(%MyApp.User{}, %{ first_name: "Alex, last_name: "Garibay" })

#     changeset = BaxterPoll.Poll.changeset(%BaxterPoll.Poll{}, %{name: "Encuesta 1", description: "Encuesta de inducción", active: true})
#     poll = Repo.insert(changeset)

#     case poll do
#        {:ok, poll_model}->
#        	Logger.info "poll = #{inspect poll_model}"
#        {:error, _changeset}->
#        	Logger.error "changeset = #{inspect changeset}"
#     end

	  
#   end

#   def seed(:prod) do
#     # Proceed with caution for production
#   end
# end  