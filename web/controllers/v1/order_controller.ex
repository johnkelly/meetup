defmodule Meetup.V1.OrderController do
  @moduledoc """
  V1 Order Endpoints
  """
  use Meetup.Web, :controller

  alias Meetup.Order
  alias Meetup.Repo

  plug :scrub_params, "order" when action in [:create]

  @apidoc """
  @api {get} /v1/orders Lists orders
  @apiVersion 1.0.0
  @apiName OrderIndex
  @apiGroup Order
  @apiSuccessExample {json} Response-200:
    HTTP/1.1 200 OK
    content-type: application/json; charset=utf-8
    {
      "orders": [
        {
          "id": 1,
          "item_id": 43,
          "user_id": 678,
          "subtotal": "67.38",
          "tax": "6.00",
          "total": "63.38",
          "inserted_at": "2016-04-14T21:41:17Z",
          "updated_at": "2016-04-14T21:41:17Z",
        },
        {
          "id": 2,
          "item_id": 343,
          "user_id": 1293,
          "subtotal": "30.21",
          "tax": "3.03",
          "total": "33.24",
          "inserted_at": "2016-04-14T22:42:19Z",
          "updated_at": "2016-04-14T22:42:19Z",
        },
        ...
      ]
    }

  """
  def index(conn, _params) do
    render(conn, "index.json", data: Repo.all(Order))
  end

  @apidoc """
  @api {post} /v1/orders Creates an order
  @apiVersion 1.0.0
  @apiName OrderCreate
  @apiGroup Order
  @apiParamExample {json} Request-body:
  {
    "order": {
      "item_id": 234,
      "user_id": 55,
      "subtotal": 34.23,
      "tax":  7.42,
      "total": 41.65
    }
  }
  @apiSuccessExample {json} Response-201:
    HTTP/1.1 200 OK
    content-type: application/json; charset=utf-8
    {
      "id": 100,
      "item_id": 234,
      "user_id": 55,
      "subtotal": "34.23",
      "tax": "7.42",
      "total": "41.65",
      "inserted_at": "2016-06-12T21:41:17Z",
      "updated_at": "2016-06-12T21:41:17Z",
    }
    @apiErrorExample {text} Response-400:
      HTTP/1.1 400 Bad Request
    Bad Request
    @apiErrorExample {text} Response-422:
      HTTP/1.1 422 Unprocessable Entity
      content-type: application/json; charset=utf-8
      {
        "errors": {
          "item_id": [
            "can't be blank"
          ],
          "tax": [
            "can't be blank"
          ]
        }
      }
  """
  def create(conn, %{"order" => order_params}) do
    whitelist = ~w(item_id user_id subtotal tax total)
    params    = Map.take(order_params, whitelist)
    changeset = Order.changeset(%Order{}, params)

    case Repo.insert changeset do
      {:ok, order} ->
        conn
        |> put_status(201)
        |> put_resp_header("location", v1_order_path(conn, :show, order))
        |> render("show.json", data: order)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(Meetup.ChangesetView, "error.json", changeset: changeset)
    end
  end

  @apidoc """
  @api {get} /v1/orders/:id View order
  @apiVersion 1.0.0
  @apiName OrderShow
  @apiGroup Order
  @apiSuccessExample {json} Response-200:
    HTTP/1.1 200 OK
    content-type: application/json; charset=utf-8
    {
      "order": {
          "id": 1,
          "item_id": 43,
          "user_id": 678,
          "subtotal": "67.38",
          "tax": "6.00",
          "total": "63.38",
          "inserted_at": "2016-04-14T21:41:17Z",
          "updated_at": "2016-04-14T21:41:17Z",
        }
    }
  @apiErrorExample {text} Response-404:
  HTTP/1.1 404 Not Found
  Not Found
  """
  def show(conn, %{"id" => id}) do
    order = Repo.get_by(Order, id: id)

    case order do
      nil ->
        send_resp(conn, 404, "Not Found")
      _ ->
        render(conn, "show.json", data: order)
    end
  end
end
