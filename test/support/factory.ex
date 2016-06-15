defmodule Meetup.Factory do
  use ExMachina.Ecto, repo: Meetup.Repo

  def factory(:order) do
    f_subtotal = Float.round(:random.uniform() * 100, 2)
    subtotal   = Decimal.new(f_subtotal)
    tax        = Decimal.new(Float.round(f_subtotal * 0.06, 2))
    total      = Decimal.add(subtotal, tax)

    %Meetup.Order{
      item_id: round(:random.uniform() * 100_000),
      user_id: round(:random.uniform() * 100_000),
      subtotal: subtotal,
      tax: tax,
      total: total
    }
  end
end
