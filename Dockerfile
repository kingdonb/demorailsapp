# This Dockerfile uses the latest version of the Bitnami Rails Docker image
FROM kingdonb/rails:postgresql

# The following operations need to be executed as root
USER root

# We install the javascript environment needed by rails
RUN install_packages nodejs

# Copy app's Gemfile dependency information
COPY Gemfile Gemfile.lock /app/

USER root
# Actions will be performed by the user 'bitnami', so it's good practice
# to explicitly set the required permissions
RUN chown -R bitnami:bitnami /app /home/bitnami

# Change the effective UID from 'root' to 'bitnami'
# Never run application code (or bundler) as 'root'!
USER bitnami

# Install the application dependencies defined in the Gemfile
RUN bundle install

USER root
# Copy app's source code to the /app directory
COPY . /app
RUN chown -R bitnami:bitnami /app /home/bitnami
USER bitnami

# The application's directory will be the working directory
WORKDIR /app
RUN bundle check
