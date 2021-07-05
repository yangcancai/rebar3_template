#!/bin/bash -x
IMAGE="rabbitmq_golden_exchange"
DOCKER_PORT="-v $(pwd)/tmp:/tmp -v $(pwd)/rabbitmq/etc:/etc/rabbitmq -v $(pwd)/rabbitmq/lib:/var/lib/rabbitmq -v $(pwd)/rabbitmq/log:/var/log/rabbitmq -p 15672:15672 -p 5672:5672"
PROJ_DIR="/app"
DOCKER_OPTION=" run -it --rm --name $IMAGE $DOCKER_PORT  -v "$(pwd):$PROJ_DIR" $IMAGE /bin/bash -c "
. ./util.sh
build_docker(){
	docker build --compress --rm -t rabbitmq_golden_exchange .
}
attach_docker(){
	run_docker "bash"
}
run(){
	cd /app 
	cd /rabbitmq_golden_exchange/rabbitmq-server/deps
	cp -r /app rabbitmq_golden_exchange
	cd rabbitmq_golden_exchange
	rm -rf .erlang.mk ebin escript.lock escript plugins plugins.lock rabbitmq_golden_exchange.d sbin sbin.lock
	make 
	make dist
	cp -r plugins/* /app/plugins
	cd /rabbitmq_golden_exchange/rabbitmq-server
	make run-broker PLUGINS='rabbitmq_golden_exchange rabbitmq_management'

}
run_docker(){
	docker $DOCKER_OPTION "$1"
}
execute(){
	docker $DOCKER_OPTION "sh tool.sh run"
}
do_tar(){
	mkdir -p rabbitmq_golden_exchange
	cp -r .dockerignore .gitattributes .gitignore Dockerfile Makefile README.md erlang.mk rabbitmq-components.mk src tool.sh util.sh rabbitmq_golden_exchange
	mkdir -p rabbitmq_golden_exchange/plugins
	tar -zcf rabbitmq_golden_exchange.tar.gz rabbitmq_golden_exchange
	rm -rf rabbitmq_golden_exchange
}
help(){
	echo "sh tool.sh build_docker : Build the rabbitmq_golden_exchange image of docker"
	echo "sh tool.sh attach_docker       : Attach to the rabbitmq_golden_exchange image"
	echo "sh tool.sh make: Compile source & start-broker"
	echo "sh tool.sh tar: Tar source to rabbitmq_golden_exchange.tar.gz"
}
case $1 in
build_docker) build_docker;;
attach_docker) attach_docker;;
make) execute;;
run) run;;
help) help;;
tar) do_tar;;
*) help
esac
