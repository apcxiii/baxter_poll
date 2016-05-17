defmodule Mix.Tasks.BaxterPoll.Seed do  
  use Mix.Task
  alias BaxterPoll.Repo
  use Ecto.Migration
  require Logger

  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  def seed(:dev) do
    # Any data for development goes here
    # i.e. Repo.insert!(%MyApp.User{}, %{ first_name: "Alex, last_name: "Garibay" })
    create_poll_topic_types 
    create_poll 
    create_users(10)	  
  end

  def seed(:prod) do
    create_poll_topic_types 
    create_poll 
    create_users(1000)
  end


  defp create_poll do
    changeset = BaxterPoll.Poll.changeset(%BaxterPoll.Poll{}, %{name: "Encuesta 1", description: "Encuesta de inducción", active: true})
    poll = Repo.insert(changeset)

    case poll do
       {:ok, poll_model}->
        Logger.info "poll = #{inspect poll_model}"
        create_topics(poll_model)
       {:error, _changeset}->
        Logger.error "changeset = #{inspect changeset}"
    end
  end

  defp create_poll_topic_types do
    Repo.insert!(BaxterPoll.PollTopicType.changeset(%BaxterPoll.PollTopicType{}, %{description: "Abierta"}))
    Repo.insert!(BaxterPoll.PollTopicType.changeset(%BaxterPoll.PollTopicType{}, %{description: "Múltiple"}))
  end

  defp create_topics(poll) do
    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "El programa de introducción a Baxter, me permitió conocer la misión, visión así como los principales objetivos de la empresa.",
       order: 1, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "Acorde a la información revisada, pude comprender la estructura de la organización.",
       order: 2, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "La estructura del programa fue adecuada para entender el funcionamiento de cada una de las unidades del negocio.",
       order: 3, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "Los acompañamientos en campo me permitieron conocer y entender el portafolio de productos y terapias dentro de Baxter.",
       order: 4, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "Considerando la información recibida, pude identificar mi rol dentro de la operación.",
       order: 5, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "Los facilitadores me transmitieron sentido de pertenencia hacia la empresa durante sus presentaciones.",
       order: 6, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "La duración del programa fue adecuada para conocer, entender y facilitar mi integración a Baxter.",
       order: 7, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "La bienvenida que recibí en la empresa me generó motivación y cumplió mis expectativas.",
       order: 8, active: true, poll_id: poll.id, poll_topic_type_id: 1}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "¿Cuáles fueron los temas que causaron mayor impacto durante tu proceso de inducción?",
       order: 9, active: true, poll_id: poll.id, poll_topic_type_id: 2}))

    Repo.insert!(BaxterPoll.PollTopic.changeset(%BaxterPoll.PollTopic{},
     %{text: "¿Qué aspectos consideras que podrían enriquecer el proceso de inducción?",
       order: 10, active: true, poll_id: poll.id, poll_topic_type_id: 2}))
  end 

  defp create_users(n) do
    

    Enum.each(1..n, fn(x) -> 
      case Repo.insert(BaxterPoll.User.changeset(%BaxterPoll.User{}, %{process: false, area: nil,
                                                                       name: nil, 
                                                                       second_last_name: nil, 
                                                                       first_last_name: nil,
                                                                       email: nil})) do       
        {:ok, user_model}->
          Logger.info "poll = #{inspect user_model}"          
          create_poll_users(user_model) 
          create_user_answers(user_model)

        {:error, changeset}->
          Logger.error "changeset = #{inspect changeset}"
      end
    end)
  end

  defp insert_user_multiple_times (n) do    
    insert_user_multiple_times(n - 1)
  end

  defp create_poll_users(user) do
    Repo.insert!(BaxterPoll.PollUser.changeset(%BaxterPoll.PollUser{}, %{user_id: user.id, poll_id: 1}))
  end

  defp create_user_answers(user) do
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 1}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 2}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 3}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 4}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 5}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 6}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 7}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 8}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 9}))
    Repo.insert!(BaxterPoll.UserPollAnswer.changeset(%BaxterPoll.UserPollAnswer{}, %{user_id: user.id, poll_id: 1, poll_topic_id: 10}))    
  end
end  