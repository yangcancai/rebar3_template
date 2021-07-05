#!/bin/bash -x
IMAGE="{{name}}"
DOCKER_PORT="-v $(pwd)/tmp:/tmp -v $(pwd)/rabbitmq/etc:/etc/rabbitmq -v $(pwd)/rabbitmq/lib:/var/lib/rabbitmq -v $(pwd)/rabbitmq/log:/var/log/rabbitmq -p 15672:15672 -p 5672:5672"
PROJ_DIR="/app"
DOCKER_OPTION=" run -it --rm --name $IMAGE $DOCKER_PORT  -v "$(pwd):$PROJ_DIR" $IMAGE /bin/bash -c "
. ./util.sh
build_docker(){
	docker build --compress --rm -t {{name}} .
}
attach_docker(){
	run_docker "bash"
}
run(){
	cd /app 
	cd /{{name}}/rabbitmq-server/deps
	cp -r /app {{name}}
	cd {{name}}
	rm -rf .erlang.mk ebin escript.lock escript plugins plugins.lock {{name}}.d sbin sbin.lock
	make 
	make dist
	cp -r plugins/* /app/plugins
	cd /{{name}}/rabbitmq-server
	make run-broker PLUGINS='{{name}} rabbitmq_management'

}
run_docker(){
	docker $DOCKER_OPTION "$1"
}
execute(){
	docker $DOCKER_OPTION "sh tool.sh run"
}
do_tar(){
	mkdir -p {{name}}
	cp -r .dockerignore .gitattributes .gitignore Dockerfile Makefile README.md erlang.mk rabbitmq-components.mk src tool.sh util.sh {{name}}
	mkdir -p {{name}}/plugins
	tar -zcf {{name}}.tar.gz {{name}}
	rm -rf {{name}}
}
help(){
	echo "sh tool.sh build_docker : Build the {{name}} image of docker"
	echo "sh tool.sh attach_docker       : Attach to the {{name}} image"
	echo "sh tool.sh make: Compile source & start-broker"
	echo "sh tool.sh tar: Tar source to {{name}}.tar.gz"
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
