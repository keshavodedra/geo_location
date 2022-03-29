FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cron && apt-get -y install graphviz
RUN mkdir /geo-location-app
WORKDIR /geo-location-app
ENV EDITOR=code
COPY Gemfile /geo-location-app/Gemfile
COPY Gemfile.lock /geo-location-app/Gemfile.lock
RUN gem install bundler:2.3.2
RUN bundle install
COPY . /geo-location-app
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0","-e","development"]