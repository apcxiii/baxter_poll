defmodule BaxterPoll.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :first_last_name, :string
      add :second_last_name, :string
      add :created_at, :datetime
      add :updated_at, :datetime
    end
     create unique_index(:users, [:email])
  end

  def down do
    drop_if_exists table(:users)
  end
end
