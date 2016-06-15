defmodule Meetup.V2.OrderControllerTest do
  use Meetup.ConnCase

  test "#index" do
    order = create(:order)
    conn = get conn, v2_order_path(conn, :index)
    resp = json_response(conn, 200)

    assert resp["orders"] == [%{
      "id"          => order.id,
      "item_id"     => order.item_id,
      "user_id"     => order.user_id,
      "subtotal"    => convert_decimal_to_int(order.subtotal),
      "tax"         => convert_decimal_to_int(order.tax),
      "total"       => convert_decimal_to_int(order.total),
      "inserted_at" => Ecto.DateTime.to_iso8601(order.inserted_at),
      "updated_at"  => Ecto.DateTime.to_iso8601(order.updated_at)
    }]
  end

  @valid_order_attrs   %{item_id: 25, user_id: 42, subtotal: 23.00, tax: 6.00, total: 29.00}
  @invalid_order_attrs %{item_id: nil, user_id: nil, subtotal: nil, tax: nil, total: nil}

  test "#create - valid attrs" do
    conn = post conn, v2_order_path(conn, :create), order: @valid_order_attrs
    resp = json_response(conn, 201)

    assert resp["order"]["id"]
    assert resp["order"]["item_id"] == 25
    assert resp["order"]["user_id"] == 42
    assert resp["order"]["subtotal"] == 2300
    assert resp["order"]["tax"]    == 600
    assert resp["order"]["total"]  == 2900
    assert resp["order"]["inserted_at"]
    assert resp["order"]["updated_at"]
  end

  test "#create - invalid attrs" do
    conn = post conn, v2_order_path(conn, :create), order: @invalid_order_attrs
    resp = json_response(conn, 422)

    assert resp["errors"] == %{
     "item_id"  => ["can't be blank"],
     "user_id"  => ["can't be blank"],
     "subtotal" => ["can't be blank"],
     "tax"      => ["can't be blank"],
     "total"    => ["can't be blank"]
   }
  end

  test "#show - valid id" do
    order = create(:order)
    conn = get conn, v2_order_path(conn, :show, order.id)
    resp = json_response(conn, 200)

    assert resp["order"] == %{
      "id"          => order.id,
      "item_id"     => order.item_id,
      "user_id"     => order.user_id,
      "subtotal"    => convert_decimal_to_int(order.subtotal),
      "tax"         => convert_decimal_to_int(order.tax),
      "total"       => convert_decimal_to_int(order.total),
      "inserted_at" => Ecto.DateTime.to_iso8601(order.inserted_at),
      "updated_at"  => Ecto.DateTime.to_iso8601(order.updated_at)
    }
  end

  test "#show - invalid id" do
    conn = get conn, v2_order_path(conn, :show, 1_000_000)
    assert conn.status == 404
    assert conn.state  == :sent
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
