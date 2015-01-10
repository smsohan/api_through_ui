FROM ruby:2.2.0

MAINTAINER SM Sohan

RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

RUN gem install foreman --no-ri --no-rdoc
RUN gem install bundler --no-ri --no-rdoc

WORKDIR /api_through_ui

ADD ./Gemfile /api_through_ui/Gemfile
ADD ./Gemfile.lock /api_through_ui/Gemfile.lock

RUN bundle

ADD . /api_through_ui

ENV RAILS_ENV production
RUN bundle exec rake assets:precompile

ADD config/nginx-sites.conf /etc/nginx/sites-enabled/default
CMD foreman start -f Procfile





