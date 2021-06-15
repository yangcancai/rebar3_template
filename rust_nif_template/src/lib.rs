//-------------------------------------------------------------------
// @author {{author_name}}
{{rust_apache_license}}
// @doc
//
// @end
// Created : {{datetime}}
//-------------------------------------------------------------------

extern crate core;
extern crate rustler;
extern crate serde;
mod atoms;
mod options;
mod nif;
// define nif api
rustler::init!(
    "{{name}}_nif",
    [
        nif::new,
        nif::clear,
        nif::push,
        nif::pop,
        nif::list,
    ],
    load = nif::on_load
);