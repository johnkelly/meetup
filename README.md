# Meetup

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## REST API - only one item per order

## To install APIdocs:
  * `npm install apidoc -g` (http://apidocjs.com/)

## To run APIdocs:
  * From project root, `apidoc -i web/controllers/ -o apidoc/`

## To open APIdocs:
  * `open apidoc/index.html`


## Steps
* mix phoenix.new --no-html --no-brunch meetup
* Y
* mix phoenix.gen.model Order orders item_id:integer user_id:integer subtotal:decimal tax:decimal total:decimal
* mix ecto.create
* mix ecto.migrate
* Create controller test
* Create controller
* Add factories
* Create apidoc.json in project root
* Add doc to controller
* Add to gitignore
