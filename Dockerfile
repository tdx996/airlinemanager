# ./Dockerfile
FROM ruby:2.5.3
RUN apt-get update && apt-get install -y build-essential nodejs mysql-client
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 3000
CMD ["sh", "docker-cmd.sh"]