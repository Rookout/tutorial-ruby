FROM ruby:2.7.5

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle config force_ruby_platform true
RUN bundle install

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
RUN yarn install

EXPOSE 3000
CMD ["rails", "server", "-e", "development", "-b", "0.0.0.0"]
