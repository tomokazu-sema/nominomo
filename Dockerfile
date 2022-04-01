FROM ruby:3.1.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential nodejs yarn
RUN mkdir /nominomo
WORKDIR /nominomo
COPY Gemfile /nominomo/Gemfile
COPY Gemfile.lock /nominomo/Gemfile.lock
RUN bundle install
COPY . /nominomo
