setup: install

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare

install:
	cp -n .env.example .env || true
	yarn install
	bundle install
	bundle exec rails db:create
	bundle exec rails db:migrate
	bundle exec rails assets:precompile

test:
	bundle exec rake test

lint:
	bundle exec rubocop

slim-lint:
	slim-lint app/views/

run:
	bundle exec rails s

.PHONY: test
