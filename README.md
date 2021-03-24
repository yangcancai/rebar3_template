# rebar3_template

## Required

* rust environment [install rust](https://www.rust-lang.org/tools/install)
* erlang environment
* rebar3 

## How to use

* clone source to templates directory
```shell
$ cd ~/.config/rebar3
git clone  https://github.com/yangcancai/rebar3_template.git templates
```

* release proj

```shell
$ cd ~/proj/erlang
$ rebar3 new release hello_rust
===> Writing hello_rust/apps/hello_rust/src/hello_rust_app.erl
===> Writing hello_rust/apps/hello_rust/src/hello_rust_sup.erl
===> Writing hello_rust/apps/hello_rust/src/hello_rust.app.src
===> Writing hello_rust/rebar.config
===> Writing hello_rust/config/sys.config
===> Writing hello_rust/config/vm.args
===> Writing hello_rust/.gitignore
===> Writing hello_rust/LICENSE
===> Writing hello_rust/README.md
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

## Reference

* [erbloom](https://github.com/Vonmo/erbloom)
* [rebar3](https://rebar3.readme.io/docs/using-templates)