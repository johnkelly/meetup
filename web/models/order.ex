defmodule Meetup.Order do
  use Meetup.Web, :model

  schema "orders" do
    field :item_id, :integer
    field :user_id, :integer
    field :subtotal, :decimal
    field :tax, :decimal
    field :total, :decimal

    timestamps
  end

  @required_fields ~w(item_id user_id subtotal tax total)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
