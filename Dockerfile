FROM ruby:2.6.3

ENV APP /pikachu
RUN mkdir $APP
WORKDIR $APP

ADD Gemfile* $APP/
RUN gem install bundler
RUN bundle install

ADD . $APP/

EXPOSE 3000

CMD bundle exec rails server --binding 0.0.0.0 --port 3000
