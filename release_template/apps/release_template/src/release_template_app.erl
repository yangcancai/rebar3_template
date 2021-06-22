%%%-------------------------------------------------------------------
%%% @author {{author_name}}
{{apache_license}}
%%% @doc
%%%
%%% @end
%%% Created : {{datetime}}
%%%-------------------------------------------------------------------

-module({{name}}_app).

-author("{{author_name}}").

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {{name}}_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
