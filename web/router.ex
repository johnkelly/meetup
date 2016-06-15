defmodule Meetup.Router do
  use Meetup.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Meetup do
    pipe_through :api
  end
end
