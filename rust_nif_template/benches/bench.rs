//-------------------------------------------------------------------
// @author {{author_name}}
{{rust_apache_license}}
// @doc
//
// @end
// Created : {{datetime}}
//-------------------------------------------------------------------

#[macro_use]
extern crate bencher;
use bencher::Bencher;

fn get(bench: &mut Bencher) {
	bench.iter(|| {
	    assert_eq!(get_word(""),"".to_string());
	});
    }
fn get_word(str: &str) -> String{
	    str.to_string()
}
benchmark_group!(benches, get);
benchmark_main!(benches);
