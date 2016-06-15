defmodule Meetup.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :item_id, :integer
      add :user_id, :integer
      add :subtotal, :decimal
      add :tax, :decimal
      add :total, :decimal

      timestamps
    end

   create index(:orders, [:item_id]) 
   create index(:orders, [:user_id]) 

  end
end
