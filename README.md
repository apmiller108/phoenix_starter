# PhoenixStarter

## What's in it?
  * Password hashing with [*comeonin*](https://github.com/riverrun/comeonin)
  * Browser authentication with
    [*guardian*](https://github.com/ueberauth/guardian)
  * Simple user model with `email` and `password` with basic validations
  * Postgres for persistence
  * Front end stuff: [*Bulma*](http://bulma.io/) as css framework and grid system. 
    Included jQuery, too.
  * [Docker](#docker-setup)

## To rename the app
  * Edit `rename.sh`: Replace `NewName` with `YourAppName`. Replace `new_name`
    with your `your_app_name`.
  * Run the scripe with `sh rename.sh`
  * Thanks to [nerdyworm](https://gist.github.com/nerdyworm) for the
    [gist](https://gist.github.com/nerdyworm/3d623b13bf0d6d664373e2f501f16423)

## To start your Phoenix app:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`
  * Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Docker Setup
  * change `hostname:` to `postgres` in `config/div.exs` under the `Repo` config
    block
  * `$ docker compose build` - to build the container 
  * `$ docker compose run app mix ecto.create` - to create the database
  * `$ docker compose up` - to run the app.
  *  Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
  * Tip: run `docker compose run app bash` to open a bash prompt in the
    container.
  
