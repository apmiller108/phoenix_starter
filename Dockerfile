# Install Elixir from https://hub.docker.com/_/elixir/
FROM elixir:1.4.2

# Install mix package manager
RUN mix local.hex --force

# Install rebar for building Erlang packages
RUN mix local.rebar --force

# Install the Phoenix web framework
RUN mix archive.install \
  https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install nodejs and npm for brunch
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y nodejs

# Copy the app contents
WORKDIR /app
ADD . /app

# Install mix dependencies
RUN mix deps.get

# Install npm dependencies
RUN npm install
