defmodule Meetup.Router do
  use Meetup.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Meetup do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/orders", OrderController, only: [:index, :create, :show]
    end
 end
end
