defmodule BaxterPoll.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :first_last_name, :string
      add :recruiter, :string
      add :position, :string
      add :second_last_name, :string
      add :date_recruitment, :datetime
      add :created_at, :datetime
      add :updated_at, :datetime
    end     
  end

  def down do
    drop_if_exists table(:users)
  end
end
