defmodule Meetup.OrderTest do
  use Meetup.ModelCase

  alias Meetup.Order

  @valid_attrs %{item_id: 42, subtotal: "120.50", tax: "6.40", total: "126.90", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
