#!/bin/bash
build(){
    mkdir -p {{app_dir}}/priv
    cargo build --manifest-path=crates/{{name}}/Cargo.toml --release
    sh -c "cp $(cat crates/{{name}}/libpath) {{app_dir}}/priv/lib{{name}}.so "
}
test(){
    cargo test --manifest-path=crates/{{name}}/Cargo.toml 
}
clippy(){
    cargo clippy --manifest-path=crates/{{name}}/Cargo.toml 
}
help(){
    echo "sh build_crates.sh <command> :"
    echo "build              - do cargo build and cp libpath to priv"
    echo "test               - do cargo test"
    echo "clippy             - do cargo clippy to improve your rust code"
    echo "bench              - do cargo bench"
    echo "help               - help to use command"
}
bench(){
    cargo bench --manifest-path=crates/{{name}}/Cargo.toml 
}
fmt(){
    cargo fmt --manifest-path=crates/{{name}}/Cargo.toml 
}
update(){
    cargo update --manifest-path=crates/{{name}}/Cargo.toml 
}
case $1 in
fmt) fmt;;
bench) bench;;
build) build;;
test) test;;
update) update;;
clippy) clippy;;
*) help;;
esac