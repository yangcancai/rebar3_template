-module(rabbit_exchange_type_golden).

-behaviour(rabbit_exchange_type).

-include_lib("rabbit_common/include/rabbit.hrl").

-export([description/0, serialise_events/0, route/2]).
-export([info/1, info/2, validate/1, validate_binding/2, create/2, delete/3,
         policy_changed/2, add_binding/3, remove_bindings/3, assert_args_equivalence/2]).
-export([deliver/2]).
-rabbit_boot_step({?MODULE,
                   [{description,
                     "Exchange type to allow parse routing keys on items for a message"},
                    {mfa,
                     {rabbit_registry,
                      register,
                      [exchange, <<"x-golden">>, ?MODULE]}},
                    {requires, rabbit_registry},
                    {enables, kernel_ready}]}).

description() ->
    [{description,
      <<"AMQP direct-style exchange, allowing for parse routing keys "
        "per message">>}].

route(#exchange{type = direct} = Exchange, Delivery) ->
    rabbit_exchange_type_direct:route(Exchange#exchange{type = 'x-golden'}, Delivery);
route(Exchange,
      Delivery =
          #delivery{message =
                        #basic_message{routing_keys = _Rkeys,
                                       content = #content{payload_fragments_rev = _Payload}}}) ->

    %% do something
    %% RawPayload = lists:reverse(Payoad),
    %% do deliver 
    
    %% deliver to raw routing_key
    %% return [] will never route to any queue
    rabbit_exchange_type_direct:route(Exchange, Delivery).
deliver(Exchange, Delivery) ->
    Dests = rabbit_exchange:route(Exchange#exchange{type = direct}, Delivery),
    Qs = rabbit_amqqueue:lookup(Dests),
    rabbit_amqqueue:deliver(Qs, Delivery).
serialise_events() ->
    false.

info(_X) ->
    [].

info(_X, _Is) ->
    [].

validate(_X) ->
    ok.

validate_binding(_X, _B) ->
    ok.

create(_Tx, _X) ->
    ok.

delete(_Tx, _X, _Bs) ->
    ok.

policy_changed(_X1, _X2) ->
    ok.

add_binding(_Tx, _X, _B) ->
    ok.

remove_bindings(_Tx, _X, _Bs) ->
    ok.

assert_args_equivalence(X, Args) ->
    rabbit_exchange:assert_args_equivalence(X, Args).