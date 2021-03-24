extern crate core;
extern crate rustler;
extern crate serde;
extern crate ternary_tree;
mod atoms;
mod options;
mod nif;
// define nif api
rustler::init!(
    "{{name}}",
    [
        nif::new,
        nif::clear,
        nif::push,
        nif::pop,
        nif::list,
    ],
    load = nif::on_load
);