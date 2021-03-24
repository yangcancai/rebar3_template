#!/bin/bash
mkdir -p {{app_dir}}/priv
cargo build --manifest-path=crates/{{name}}/Cargo.toml --release
sh -c "cp $(cat crates/{{name}}/libpath) {{app_dir}}/priv/lib{{name}}.so "