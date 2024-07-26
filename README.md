# README

## Running instructions

To run the project, you'll need a running PostgreSQL instance,
a `DATABASE_URL` environment variable, and ruby v3.3.4.

### Using docker compose

A `docker-compose.yml` file exists for convenience. It starts a
PostgreSQL service in addition of the application.

Before the first launch, prepare a `.env` file with the following content:

```bash
POSTGRES_PASSWORD=<a_random_password>
DATABASE_URL=postgres://postgres:<a_random_password>@database:5432/app_manager_trial_development
RAILS_ENV=development
```

And a `.env.test` one:

```bash
POSTGRES_PASSWORD=<a_random_password>
DATABASE_URL=postgres://postgres:<a_random_password>@database:5432/app_manager_trial_test
RAILS_ENV=test
```

You'll need also to build the image and setup the app:

```shell
docker compose run build
docker compose run --rm web bundle install
docker compose run --rm web bundle exec rails db:prepare
```

Then, to run the app:

```shell
docker compose up
```

To execute the tests, you can use the following:

```shell
docker compose run --rm test bundle exec rspec
```
