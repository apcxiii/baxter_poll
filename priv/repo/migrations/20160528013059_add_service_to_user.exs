defmodule BaxterPoll.Repo.Migrations.AddServiceToUser do
  use Ecto.Migration

  def up do
  	alter table(:users) do
    	add :service, :string
  	end
  end

  def down do
  	alter table(:users) do
      remove :service    
    end
  end
end
