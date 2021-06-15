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

%% -include("app_ct.hrl").

-compile(export_all).

-define(APP, 'App').
all() ->
    [].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(?APP),
    new_meck(),
    Config.

end_per_suite(Config) ->
    del_meck(),
    ok = application:stop(?APP),
    Config.

init_per_testcase(_Case, Config) ->
    Config.

end_per_testcase(_Case, _Config) ->
    ok.

new_meck() ->
    % ok = meck:new({{name}}, [non_strict, no_link]),
    ok.

expect() ->
    % ok = meck:expect({{name}}, test, fun() -> {ok, 1} end).
    ok.

del_meck() ->
    meck:unload().

