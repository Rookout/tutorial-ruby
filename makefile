PUBLISH_VERSION=$(shell echo ${NEW_VERSION} | sed 's/inner-999/1/g')

build:
	docker build --tag rookout/tutorial-ruby:latest --tag rookout/tutorial-ruby:${PUBLISH_VERSION} .

upload-no-latest:
	docker push rookout/tutorial-ruby:${PUBLISH_VERSION}

upload: upload-no-latest
	@if [ ${CIRCLE_BRANCH} = "master" ]; then \
		docker push rookout/tutorial-ruby:latest; \
	fi

build-and-upload: build upload

init-devcontainer:
	rvm install "ruby-2.7"
	bash -l -c "rvm --default use 2.7 && bundle install"
	yarn install
