# Install Elixir from https://hub.docker.com/_/elixir/
FROM elixir:1.4.2

# Install mix package manager
RUN mix local.hex --force

# Install rebar for building Erlang packages
RUN mix local.rebar --force

# Install postgres client and inotify-tools (to support live reload).
# Install postgresql-9.6 to match the server version so pg_dump can be used.
RUN touch /etc/apt/sources.list.d/pgdg.list && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" \
  >> /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add - && \
  apt-get update && apt-get install -y \
  postgresql-client \
  postgresql-9.6 \
  inotify-tools && \
  ln -s /usr/lib/postgresql/9.6/bin/pg_dump /usr/bin/pg_dump --force

# Install the Phoenix web framework
RUN mix archive.install \
  https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install nodejs and npm for brunch
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs

# Copy the app contents
WORKDIR /app
ADD . /app
