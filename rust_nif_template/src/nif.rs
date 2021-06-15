//-------------------------------------------------------------------
// @author {{author_name}}
{{rust_apache_license}}
// @doc
//
// @end
// Created : {{datetime}}
//-------------------------------------------------------------------

use std::{borrow::Cow, sync::{RwLock, RwLockReadGuard, RwLockWriteGuard}};

use rustler::{resource::ResourceArc};
use rustler::{Binary, Encoder, Env, NifResult, OwnedBinary, Term};

use atoms::{ok};
use options::Nif{{name}}Options;
// =================================================================================================
// resource
// =================================================================================================
struct Nif{{name}}{
    data: Vec<String>
}
impl Nif{{name}}{
    // create
    fn new(_: Nif{{name}}Options) -> Result<Self, String>{
        Ok(Nif{{name}}{data: vec![]})
    }
    // clear
    fn clear(&mut self) {
        self.data.clear();
    }
    // write
    fn push(&mut self, msg: &[u8]) {
       self.push_string(self.u8_to_string(msg))
    }
    fn u8_to_string(&self, msg: &[u8]) -> String{
        let a = String::from_utf8_lossy(msg);
        match a{
            Cow::Owned(own_msg) => own_msg,
            Cow::Borrowed(b_msg) => b_msg.to_string()
        }
    }
    fn push_string(&mut self, msg: String){
        self.data.push(msg)
    }
    // read
    fn pop(&mut self) -> Option<String>{
        self.data.pop()
    }
    fn list(&self) -> Vec<String>{
        self.data.clone()
    }
}
#[repr(transparent)]
struct Nif{{name}}Resource(RwLock<Nif{{name}}>);

impl Nif{{name}}Resource {
    fn read(&self) -> RwLockReadGuard<'_, Nif{{name}}> {
        self.0.read().unwrap()
    }

    fn write(&self) -> RwLockWriteGuard<'_, Nif{{name}}> {
        self.0.write().unwrap()
    }
}

impl From<Nif{{name}}> for Nif{{name}}Resource {
    fn from(other: Nif{{name}}) -> Self {
        Nif{{name}}Resource(RwLock::new(other))
    }
}

pub fn on_load(env: Env, _load_info: Term) -> bool {
    rustler::resource!(Nif{{name}}Resource, env);
    true
}

// =================================================================================================
// api
// =================================================================================================

#[rustler::nif]
fn new<'a>(env: Env<'a>, opts: Nif{{name}}Options) -> NifResult<Term<'a>> {
    let rs = Nif{{name}}::new(opts).map_err(|e| rustler::error::Error::Term(Box::new(e)))?;
    Ok((ok(), ResourceArc::new(Nif{{name}}Resource::from(rs))).encode(env))
}
#[rustler::nif]
fn clear<'a>(env: Env<'a>, resource: ResourceArc<Nif{{name}}Resource>) -> NifResult<Term<'a>> {
    resource.write().clear();
    Ok(ok().encode(env))
}
#[rustler::nif]
fn push<'a>(env: Env<'a>, resource: ResourceArc<Nif{{name}}Resource>, msg: LazyBinary<'a>) -> NifResult<Term<'a>> {
    let mut rs = resource.write();
    rs.push(&msg);
   Ok(ok().encode(env)) 
}
#[rustler::nif]
fn pop<'a>(env: Env<'a>, resource: ResourceArc<Nif{{name}}Resource>) -> NifResult<Term<'a>> {
    let mut rs = resource.write();
    let p = rs.pop();
   Ok(p.encode(env)) 
}
#[rustler::nif]
fn list<'a>(env: Env<'a>, resource: ResourceArc<Nif{{name}}Resource>) -> NifResult<Term<'a>> {
    let rs = resource.read();
    let list = rs.list();
    Ok(list.encode(env))
}

// =================================================================================================
// helpers
// =================================================================================================

/// Represents either a borrowed `Binary` or `OwnedBinary`.
///
/// `LazyBinary` allows for the most efficient conversion from an
/// Erlang term to a byte slice. If the term is an actual Erlang
/// binary, constructing `LazyBinary` is essentially
/// zero-cost. However, if the term is any other Erlang type, it is
/// converted to an `OwnedBinary`, which requires a heap allocation.
enum LazyBinary<'a> {
    Owned(OwnedBinary),
    Borrowed(Binary<'a>),
}

impl<'a> std::ops::Deref for LazyBinary<'a> {
    type Target = [u8];
    fn deref(&self) -> &[u8] {
        match self {
            Self::Owned(owned) => owned.as_ref(),
            Self::Borrowed(borrowed) => borrowed.as_ref(),
        }
    }
}

impl<'a> rustler::Decoder<'a> for LazyBinary<'a> {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        if term.is_binary() {
            Ok(Self::Borrowed(Binary::from_term(term)?))
        } else {
            Ok(Self::Owned(term.to_binary()))
        }
    }
}
