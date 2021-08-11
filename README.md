# rebar3_template

## Features

* new app
* new release
* new rust_nif(Develop rust nif for erlang)
* new rabbit_exchange_type (Develop rabbitmq exchange plugin)
* new sup
* new suite
* new mod
* new hrl
* new gen_server
* new gen_statem
* new eunit
* new redis_module (A redis module template )
* rebar3 new to show help

```shell
  $rebar3 new
  app (custom): New app command: 
         rebar3 new app {{name}} NAME={{NAME}}
cmake (built-in): Standalone Makefile for building C/C++ in c_src
escript (built-in): Complete escriptized application structure
eunit (custom): New eunit file to path, command: 
         rebar3 new eunit {{name}} path={{path}}
gen_server (custom): New gen_server file to path, command: 
         rebar3 new gen_server {{name}} path={{path}}
gen_statem (custom): New gen_statem file to path, command: 
         rebar3 new gen_statem {{name}} path={{path}}
hrl (custom): New hrl file to path, command: 
         rebar3 new hrl {{name}} path={{path}}
lib (built-in): Complete OTP Library application (no processes) structure
mod (custom): New module file to path, command: 
         rebar3 new mod {{name}} path={{path}}
plugin (built-in): Rebar3 plugin project structure
rabbit_exchange_type (custom): A basic Common rabbitmq_exchange_type plugin project for an OTP application, command: 
         rebar3 new rabbit_exchange_type {{name}} type={{type}}
redis_module (custom): A basic Common redis module project ,command: 
         rebar3 new redis_module {{name}} NAME={{NAME}} Name={{Name}}
release (custom): A basic Common release project for an OTP application, command: 
         rebar3 new release {{name}} NAME={{NAME}}
rust (custom): New module file to path, command: 
         rebar3 new rust {{name}} path={{path}}
rust_nif (custom): A basic Common Rust nif project for an OTP application, command: 
          Releases proj: rebar3 new rust_nif {{name}} app_dir="apps/{{app}}", 
          App proj: rebar3 new rust_nif {{name}}
suite (custom): New suite file to path, command: 
         rebar3 new suite {{name}} path={{path}}
sup (custom): New supervisor file to path, command: 
         rebar3 new sup {{name}} path={{path}}
umbrella (built-in): OTP structure for executable programs (alias of 'release' template)
```
## Required

* rust environment(for new rust_nif) [install rust](https://www.rust-lang.org/tools/install)
* erlang environment
* rebar3 
* Docker (for new rabbit_exchange_type)[install docker](https://www.docker.com/products/docker-desktop)

## How to use

* clone source to templates directory

```shell
$ cd ~/.config/rebar3
git clone  https://github.com/yangcancai/rebar3_template.git templates
```

* release proj

```shell
$ cd ~/proj/erlang
$ rebar3 new release hello_rust NAME='HELLO_RUST'
===> Writing hello_rust/test/ct/ct.config
===> Writing hello_rust/test/eunit/template_test.tpl
===> Writing hello_rust/test/ct/hello_rust_ct.hrl
===> Writing hello_rust/test/ct/hello_rust_SUITE.erl
===> Writing hello_rust/test/eunit/hello_rust_test.erl
===> Writing hello_rust/GIT_COMMIT_IDS
===> Writing hello_rust/LICENSE
===> Writing hello_rust/.gitignore
===> Writing hello_rust/VERSION
===> Writing hello_rust/rebar3
===> Writing hello_rust/Makefile
===> Writing hello_rust/Dockerfile
===> Writing hello_rust/scripts/extensions/reload
===> Writing hello_rust/scripts/hooks/post_install_upgrade.sh
===> Writing hello_rust/scripts/hooks/post_start.sh
===> Writing hello_rust/scripts/hooks/post_stop.sh
===> Writing hello_rust/scripts/hooks/pre_install_upgrade.sh
===> Writing hello_rust/scripts/hooks/pre_start.sh
===> Writing hello_rust/scripts/hooks/pre_stop.sh
===> Writing hello_rust/scripts/docker.sh
===> Writing hello_rust/scripts/ssh.sh
===> Writing hello_rust/scripts/util.sh
===> Writing hello_rust/tool.sh
===> Writing hello_rust/README.md
===> Writing hello_rust/.gitlab-ci.yml
===> Writing hello_rust/rebar.config
===> Writing hello_rust/rebar.config.script
===> Writing hello_rust/config/sys.config.src
===> Writing hello_rust/config/vm.args.src
===> Writing hello_rust/apps/hello_rust/src/hello_rust_app.erl
===> Writing hello_rust/apps/hello_rust/src/hello_rust_sup.erl
===> Writing hello_rust/apps/hello_rust/src/hello_rust.app.src
===> Writing hello_rust/apps/hello_rust/src/hello_rust.app.src.script
===> Writing hello_rust/apps/hello_rust/src/hello_rust.erl
$ cd hello_rust
$ rebar3 new rust_nif my app_dir="apps/hello_rust"
===> Writing .cargo/config
===> Writing crates/my/Cargo.toml
===> Writing crates/my/Cargo.lock
===> Writing crates/my/src/atoms.rs
===> Writing crates/my/src/lib.rs
===> Writing crates/my/src/nif.rs
===> Writing crates/my/src/options.rs
===> Writing crates/my/build.rs
===> Writing crates/build_crates.sh
===> Writing apps/hello_rust/src/my_nif.erl
$ sh crates/build_crates.sh
Compiling proc-macro2 v1.0.13
   Compiling unicode-xid v0.2.0
   Compiling syn v1.0.22
   Compiling unicode-segmentation v1.6.0
   Compiling void v1.0.2
   Compiling rustler_sys v2.1.0
   Compiling rustler v0.22.0-rc.0
   Compiling serde v1.0.110
   Compiling lazy_static v1.4.0
   Compiling my v0.1.0 (/Users/admin/proj/erlang/hello_rust/crates/my)
   Compiling unreachable v1.0.0
   Compiling heck v0.3.1
   Compiling quote v1.0.6
   Compiling rustler_codegen v0.22.0-rc.0
   Compiling serde_derive v1.0.110
   Finished release [optimized] target(s) in 19.86s
$ rebar3 shell
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling hello_rust
Erlang/OTP 22 [erts-10.7.2.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Eshell V10.7.2.1  (abort with ^G)
1> ===> Booted hello_rust
===> Booted sasl
 
1> {ok, P} = my_nif:new().
{ok,#Ref<0.3586563750.363724801.187328>}
2> my_nif:list(P).
[]
3> my_nif:push(P,<<"hello">>).
ok
4> my_nif:list(P).            
[<<"hello">>]
5> my_nif:clear(P).
ok
6> my_nif:list(P). 
[]
7> my_nif:push(P,<<"1">>).    
ok
8> my_nif:push(P,<<"2">>).
ok
9> my_nif:list(P).        
[<<"1">>,<<"2">>]
10> my_nif:pop(P). 
<<"2">>
11> my_nif:pop(P).
<<"1">>
12> my_nif:pop(P).
nil
13> 
```

* app proj

```shell
$ cd ~/proj/erlang
$ rebar3 new app hello_rust
$ cd hello_rust
$ rebar3 new rust_nif my
...........................
```

* new gen_server

```shell
$ rebar3 new gen_server hello_proc path=test
===> Writing test/hello_proc.erl
```

* new gen_statem

```shell
$ rebar3 new gen_statem hello_statem path=test
===> Writing test/hello_statem.erl
```

* new mod

```shell
$ rebar3 new mod hello path=test
===> Writing test/hello.erl
```

* new hrl

```shell
$ rebar3 new hrl hello path=test
===> Writing test/hello.hrl
```

* new supervisor

```shell
$ rebar3 new sup hello path=test
===> Writing test/hello_sup.erl
```

* new eunit

```shell
$ rebar3 new eunit hello path=test
===> Writing test/hello_test.erl
```

* new suite

```shell
$ rebar3 new suite hello path=test
===> Writing test/hello_SUITE.erl
```

* new rabbit_exchange_type
  
```shell
$ rebar3 new rabbit_exchange_type rabbitmq_hello_exchange type=hello
===> Writing rabbitmq_hello_exchange/test/ct/ct.config
===> Writing rabbitmq_hello_exchange/test/eunit/template_test.tpl
===> Writing rabbitmq_hello_exchange/test/ct/rabbitmq_hello_exchange_ct.hrl
===> Writing rabbitmq_hello_exchange/test/ct/rabbitmq_hello_exchange_SUITE.erl
===> Writing rabbitmq_hello_exchange/test/eunit/rabbitmq_hello_exchange_test.erl
===> Writing rabbitmq_hello_exchange/LICENSE
===> Writing rabbitmq_hello_exchange/.gitignore
===> Writing rabbitmq_hello_exchange/.gitattributes
===> Writing rabbitmq_hello_exchange/.dockerignore
===> Writing rabbitmq_hello_exchange/Makefile
===> Writing rabbitmq_hello_exchange/tool.sh
===> Writing rabbitmq_hello_exchange/util.sh
===> Writing rabbitmq_hello_exchange/src/rabbit_exchange_type_hello.erl
===> Writing rabbitmq_hello_exchange/README.md
===> Writing rabbitmq_hello_exchange/Dockerfile
===> Writing rabbitmq_hello_exchange/erlang.mk
===> Writing rabbitmq_hello_exchange/rabbitmq-components.mk
$ cd rabbitmq_hello_exchange
$ sh tool.sh build_docker
Sending build context to Docker daemon   65.7kB
Step 1/10 : FROM elixir:1.11.4
 ---> bd3279080dc1
Step 2/10 : ENV LANG=C.UTF-8
 ---> Using cache
 ---> 200eb0783750
Step 3/10 : RUN apt-get -y update
 ---> Using cache
 ---> a2c2616d3c4b
Step 4/10 : RUN apt-get -y install         curl         git         make         python         rsync         zip
 ---> Using cache
 ---> 6b4bd920ba74
Step 5/10 : WORKDIR /rabbitmq_hello_exchange
 ---> Running in 68938f609fd1
Removing intermediate container 68938f609fd1
 ---> dc64cb66a64d
............................................
............................................
$ sh tool.sh make
make[1]: Entering directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit_common'
make[1]: Leaving directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit_common'
make[1]: Entering directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit'
make[2]: Entering directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit/apps/rabbitmq_prelaunch'
make[2]: Leaving directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit/apps/rabbitmq_prelaunch'
make[2]: Entering directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbitmq_cli'
make[2]: Leaving directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbitmq_cli'
make[1]: Leaving directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit'
 DEPEND rabbitmq_hello_exchange.d
 ERLC   rabbit_exchange_type_hello.erl
 APP    rabbitmq_hello_exchange
make[1]: Entering directory '/rabbitmq_hello_exchange/rabbitmq-server/deps/rabbit_common'
............................................
............................................

              RabbitMQ 3.8.15
        
              Copyright (c) 2007-2021 VMware, Inc. or its affiliates.
            
              Licensed under the MPL 2.0. Website: https://rabbitmq.com

  Doc guides: https://rabbitmq.com/documentation.html
  Support:    https://rabbitmq.com/contact.html
  Tutorials:  https://rabbitmq.com/getstarted.html
  Monitoring: https://rabbitmq.com/monitoring.html

  Logs: /tmp/rabbitmq-test-instances/rabbit@2808d93eceb1/log/rabbit@2808d93eceb1.log
        /tmp/rabbitmq-test-instances/rabbit@2808d93eceb1/log/rabbit@2808d93eceb1_upgrade.log

  Config file(s): /tmp/rabbitmq-test-instances/test.config

  Starting broker... completed with 4 plugins.
1>

$ ls -al plugins | grep hello
-rw-r--r--   1 admin  staff     7502  7  5 12:17 rabbitmq_hello_exchange-3.8.15.ez
```

* new redis module

```shell
$ rebar3 new redis_module hello NAME=HELLO Name=Hello
===> Writing hello/modules/.gitignore
===> Writing hello/modules/hello.c
===> Writing hello/modules/Makefile
===> Writing hello/Makefile
===> Writing hello/README.md
===> Writing hello/redismodule.h
$ cd hello
$ make && redis-server --loadmodule modules/hello.so
cd modules && /Library/Developer/CommandLineTools/usr/bin/make all
make[1]: Nothing to be done for `all'.
3113:C 11 Aug 2021 10:45:29.190 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
3113:C 11 Aug 2021 10:45:29.190 # Redis version=6.0.9, bits=64, commit=00000000, modified=0, pid=3113, just started
3113:C 11 Aug 2021 10:45:29.190 # Configuration loaded
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis 6.0.9 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._                                   
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 3113
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           http://redis.io        
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               

3113:M 11 Aug 2021 10:45:29.193 # Server initialized
3113:M 11 Aug 2021 10:45:29.941 * Module 'hello' loaded from modules/hello.so
3113:M 11 Aug 2021 10:45:29.941 * Ready to accept connections

$ redis-cli
127.0.0.1:6379> hello.insert player id01 60 100 name foo money 100
(integer) 1
127.0.0.1:6379> hello.get player
1) 1) "name"
   2) "foo"
   3) "money"
   4) "100"
   5) "id"
   6) "id01"
```

## Reference

* [erbloom](https://github.com/Vonmo/erbloom)
* [rebar3](https://rebar3.readme.io/docs/using-templates)
