PROJECT = {{name}} 
PROJECT_DESCRIPTION = RabbitMQ {{type}} Exchange Type

DEPS = rabbit_common rabbit jsx
DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk
DEP_EARLY_PLUGINS = rabbit_common/mk/rabbitmq-early-plugin.mk

# FIXME: Use erlang.mk patched for RabbitMQ, while waiting for PRs to be
# reviewed and merged.

ERLANG_MK_REPO = https://github.com/ninenines/erlang.mk.git
ERLANG_MK_COMMIT = master

include rabbitmq-components.mk
include erlang.mk
