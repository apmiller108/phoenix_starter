# PhoenixStarter

## What's in it?
  * Password hashing with [*comeonin*](https://github.com/riverrun/comeonin)
  * Browser authentication with
    [*guardian*](https://github.com/ueberauth/guardian)
  * Simple user model with `email` and `password` with basic validations
  * Postgres for persistence
  * Front end stuff: [*Bulma*](http://bulma.io/) as css framework and grid 
    system;
    Sass support; included jQuery, too.
  * [Docker](#docker-setup)

## To rename the app
  * Make `rename.sh` script executable with `$ chmod +x rename.sh`
  * Run `./rename.sh` and pass the new name value as an argument. Example:
    `$ ./rename.sh my_new_name`. IMPORTANT: the new name argument must to 
    snake_case.
  * You will be prompted to confirm the name. After confriming, all references
    to `phoenix_starter` will be changes to `my_new_name`.  All references to
    `PhoenixStarter` will be changed to `MyNewName`.

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
  * `$ docker compose run app mix deps.get` - to install dependencies
  * `$ docker compose run app mix ecto.setup` - to create and migrate the
    database
  * `$ docker compose run app npm install` - to install Node.js dependencies
  * `$ docker compose up` - to run the app.
  * Now you can visit [`localhost:4000`](http://localhost:4000) from your 
    browser.
  * Tip: run `docker compose run app bash` to open a bash prompt in the
    container.
  
