defmodule BaxterPoll.Repo.Migrations.AddFieldsToUser do
  use Ecto.Migration

  def up do
  	alter table(:users) do
    	add :process, :boolean
  	end
  end

  def down do
  	alter table(:users) do
      remove :process    
    end
  end
end
