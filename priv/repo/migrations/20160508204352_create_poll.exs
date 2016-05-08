defmodule BaxterPoll.Repo.Migrations.CreatePoll do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:polls) do
      add :name, :string
      add :description, :string
      add :active, :boolean, default: false
      add :created_at, :datetime
      add :updated_at, :datetime
    end
  end

    def down do
    	drop_if_exists table(:polls)
  	end  
end
