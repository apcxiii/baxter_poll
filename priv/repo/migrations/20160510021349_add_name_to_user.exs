defmodule BaxterPoll.Repo.Migrations.AddNameToUser do
  use Ecto.Migration

  def up do
		alter table(:users) do
    	add :name, :string
    	add :area, :string
  	end
	end

	def down do
		alter table(:users) do
      remove :name
      remove :area
    end
	end
end
