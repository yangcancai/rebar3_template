FROM elixir:1.11.4
# erlang 23

# set the environment
ENV LANG=C.UTF-8

# install needed build tools
RUN apt-get -y update
RUN apt-get -y install \
        curl \
        git \
        make \
        python \
        rsync \
        zip

# change work directory
# ADD . /{{name}}
WORKDIR /{{name}}
RUN git clone https://github.com/rabbitmq/rabbitmq-server.git &&\
        cd rabbitmq-server &&\
        git checkout v3.8.15 &&\
        make
WORKDIR /app
RUN chown root:root /app
USER root:root
ENV HOME=/app
# RUN cd .. && ln -s rabbitmq-server/deps
        
# package
# RUN make
# RUN make dist

# copy the plugin to a temporary exchange
# RUN cp plugins/{{name}}-*.ez /tmp/

# same image, different fs
# FROM rabbitmq:latest

# copy the built plugin from the other phase through to this phase
# COPY --from=build /tmp/{{name}}-*.ez ./plugins/

# enable the management plugin and the delimiter
# RUN rabbitmq-plugins enable --offline \
        # rabbitmq_management \
        # {{name}} 

# expose management ports
# EXPOSE 15671 15672
