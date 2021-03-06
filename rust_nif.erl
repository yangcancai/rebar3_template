-module({{name}}_nif).

%% API
-export([
    new/0,  %% new resource
    new/1,
    push/2,
    list/1,
    pop/1,
    clear/1 %% clear resource
]).
%% Native library support
-export([load/0]).

-on_load load/0.

-opaque {{name}}() :: reference().

-export_type([{{name}}/0]).

new() ->
    new(#{}).

-spec new(_Opts :: map()) -> {ok, Ref :: {{name}}()} | {error, Reason :: binary()}.
new(_Opts) ->
    not_loaded(?LINE).

-spec clear(Ref :: {{name}}()) -> ok.
clear(_Ref) ->
    not_loaded(?LINE).
-spec push(Ref :: {{name}}(), Msg :: binary()) -> ok.
push(_Ref, _Msg) ->
    not_loaded(?LINE).

-spec pop(Ref :: {{name}}()) -> binary() | nil.
pop(_Ref) ->
    not_loaded(?LINE).

-spec list(Ref :: {{name}}()) -> list().
list(_Ref) ->
    not_loaded(?LINE).

%% @private
load() ->
    erlang:load_nif(
        filename:join(priv(), "lib{{name}}"), none).

not_loaded(Line) ->
    erlang:nif_error({error, {not_loaded, [{module, ?MODULE}, {line, Line}]}}).

priv() ->
    case code:priv_dir(?MODULE) of
        {error, _} ->
            EbinDir =
                filename:dirname(
                    code:which(?MODULE)),
            AppPath = filename:dirname(EbinDir),
            filename:join(AppPath, "priv");
        Path ->
            Path
    end.