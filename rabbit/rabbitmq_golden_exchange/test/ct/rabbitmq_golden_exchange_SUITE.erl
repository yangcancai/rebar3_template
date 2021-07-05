-module(rabbitmq_golden_exchange_SUITE).

-include("rabbitmq_golden_exchange_ct.hrl").

-compile(export_all).

all() ->
    [handle].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(rabbitmq_golden_exchange),
    new_meck(),
    Config.

end_per_suite(Config) ->
    del_meck(),
    application:stop(rabbitmq_golden_exchange),
    Config.

init_per_testcase(_Case, Config) ->
    Config.

end_per_testcase(_Case, _Config) ->
    ok.

new_meck() ->
    ok = meck:new(rabbitmq_golden_exchange, [non_strict, no_link]),
    ok.

expect() ->
    ok = meck:expect(rabbitmq_golden_exchange, test, fun() -> {ok, 1} end).
del_meck() ->
    meck:unload().

handle(_Config) ->
    expect(),
    ?assertEqual({ok,1}, rabbitmq_golden_exchange:test()),
    ok.