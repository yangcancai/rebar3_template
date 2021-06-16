%%%-------------------------------------------------------------------
%%% @author {{author_name}}
{{apache_license}}
%%% @doc
%%%
%%% @end
%%% Created : {{datetime}}
%%%-------------------------------------------------------------------

-module({{name}}_SUITE).

-author("{{author_name}}").

-include("{{name}}_ct.hrl").

-compile(export_all).

all() ->
    [handle].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started({{name}}),
    new_meck(),
    Config.

end_per_suite(Config) ->
    del_meck(),
    application:stop({{name}}),
    Config.

init_per_testcase(_Case, Config) ->
    Config.

end_per_testcase(_Case, _Config) ->
    ok.

new_meck() ->
    ok = meck:new({{name}}, [non_strict, no_link]),
    ok.

expect() ->
    ok = meck:expect({{name}}, test, fun() -> {ok, 1} end).

del_meck() ->
    meck:unload().

handle(_Config) ->
    expect(),
    ?assertEqual({ok, 1}, {{name}}:test()),
    ok.
