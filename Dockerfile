FROM ruby:2.6.6

# set ruby and nodejs versions to install during Docker image build
ARG RUBY_VERSION=2.6.6
ARG NODE_VERSION=18.15.0

ARG USER_UID=1000

RUN apt-get update -qq \
  && apt-get install -y sudo software-properties-common build-essential git curl

# Create 'jekyll' user and enable passwordless sudo (needed by rvm to run scripts)
RUN useradd -m jekyll -G sudo -s /bin/bash --uid $USER_UID \
  && echo jekyll ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/jekyll \
  && echo "root:root" | chpasswd \
  && echo "jekyll:jekyll" | chpasswd

USER jekyll

# install rvm
RUN gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable

ENV PATH /home/jekyll/.rvm/bin/rvm:$PATH

# install ruby
RUN /bin/bash -l -c "rvm install ${RUBY_VERSION}"
RUN /bin/bash -l -c "rvm use ${RUBY_VERSION} --default"
RUN /bin/bash -l -c "gem update --system && gem install bundler:2.4.3"

# install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Add NVM to the PATH and set it to use the correct version of Node.js
ENV NVM_DIR /home/jekyll/.nvm
ENV PATH $NVM_DIR/versions/node/v${NODE_VERSION}/bin:$PATH

# install nodejs
RUN . $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm use ${NODE_VERSION}

RUN echo "alias jks='bundle exec jekyll serve --host=0.0.0.0'" >> $HOME/.bashrc

RUN mkdir /home/jekyll/app
WORKDIR /home/jekyll/app

# Mount your jekyll sources to /home/jekyll/app and live serve the website at docker run.
# And do not forget to run 'bundle install'!

CMD ["/bin/bash"]
