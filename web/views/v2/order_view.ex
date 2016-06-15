defmodule Meetup.V2.OrderView do
  @moduledoc """
  Render JSON for order data
  """

  use Meetup.Web, :view

  def render("index.json", %{data: orders}) do
    %{"orders": render_orders(orders)}
  end

  def render("show.json", %{data: order}) do
    %{"order": render_order(order)}
  end

  defp render_order(order) do
    %{
      "id"          => order.id,
      "item_id"     => order.item_id,
      "user_id"     => order.user_id,
      "subtotal"    => convert_decimal_to_int(order.subtotal),
      "tax"         => convert_decimal_to_int(order.tax),
      "total"       => convert_decimal_to_int(order.total),
      "inserted_at" => order.inserted_at,
      "updated_at"  => order.updated_at
    }
  end

  defp render_orders(orders) do
    Enum.map(orders, &render_order/1)
  end

  defp convert_decimal_to_int(decimal) do
    decimal
    |> Decimal.mult(Decimal.new(100))
    |> Decimal.to_string
    |> Integer.parse(10)
    |> Tuple.to_list
    |> hd
  end
end

