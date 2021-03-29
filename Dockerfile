FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /poker_hand
WORKDIR /poker_hand
COPY Gemfile /poker_hand/Gemfile
COPY Gemfile.lock /poker_hand/Gemfile.lock
RUN bundle install
COPY . /poker_hand
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
#CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
CMD ["rails", "server", "-b", "0.0.0.0"]
