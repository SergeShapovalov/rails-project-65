setup: install

install:
	bundle install
	yarn install
	bundle exec rails db:create
	bundle exec rails db:migrate
	bundle exec rails assets:precompile

test:
	bundle exec rake test

lint:
	bundle exec rubocop

slim-lint:
	slim-lint app/views/

.PHONY: test
