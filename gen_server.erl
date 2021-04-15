%%%-------------------------------------------------------------------
%%% @author {{author_name}}
{{apache_license}}
%%% @doc
%%%
%%% @end
%%% Created : {{datetime}}
%%%-------------------------------------------------------------------
-module({{name}}).

-author("{{author_name}}").

-behaviour(gen_server).

%% API
-export([start_link/0]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

-define(SERVER, ?MODULE).

-record({{name}}_state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
-spec start_link() -> {ok, Pid :: pid()} | ignore | {error, Reason :: term()}.
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Initializes the server
-spec init(Args :: term()) ->
              {ok, State :: #{{name}}_state{}} |
              {ok, State :: #{{name}}_state{}, timeout() | hibernate} |
              {stop, Reason :: term()} |
              ignore.
init([]) ->
    {ok, #{{name}}_state{}}.

%% @private
%% @doc Handling call messages
-spec handle_call(Request :: term(),
                  From :: {pid(), Tag :: term()},
                  State :: #{{name}}_state{}) ->
                     {reply, Reply :: term(), NewState :: #{{name}}_state{}} |
                     {reply, Reply :: term(), NewState :: #{{name}}_state{}, timeout() | hibernate} |
                     {noreply, NewState :: #{{name}}_state{}} |
                     {noreply, NewState :: #{{name}}_state{}, timeout() | hibernate} |
                     {stop, Reason :: term(), Reply :: term(), NewState :: #{{name}}_state{}} |
                     {stop, Reason :: term(), NewState :: #{{name}}_state{}}.
handle_call(_Request, _From, State = #{{name}}_state{}) ->
    {reply, ok, State}.

%% @private
%% @doc Handling cast messages
-spec handle_cast(Request :: term(), State :: #{{name}}_state{}) ->
                     {noreply, NewState :: #{{name}}_state{}} |
                     {noreply, NewState :: #{{name}}_state{}, timeout() | hibernate} |
                     {stop, Reason :: term(), NewState :: #{{name}}_state{}}.
handle_cast(_Request, State = #{{name}}_state{}) ->
    {noreply, State}.

%% @private
%% @doc Handling all non call/cast messages
-spec handle_info(Info :: timeout() | term(), State :: #{{name}}_state{}) ->
                     {noreply, NewState :: #{{name}}_state{}} |
                     {noreply, NewState :: #{{name}}_state{}, timeout() | hibernate} |
                     {stop, Reason :: term(), NewState :: #{{name}}_state{}}.
handle_info(_Info, State = #{{name}}_state{}) ->
    {noreply, State}.

%% @private
%% @doc This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
-spec terminate(Reason :: normal | shutdown | {shutdown, term()} | term(),
                State :: #{{name}}_state{}) ->
                   term().
terminate(_Reason, _State = #{{name}}_state{}) ->
    ok.

%% @private
%% @doc Convert process state when code is changed
-spec code_change(OldVsn :: term() | {down, term()},
                  State :: #{{name}}_state{},
                  Extra :: term()) ->
                     {ok, NewState :: #{{name}}_state{}} | {error, Reason :: term()}.
code_change(_OldVsn, State = #{{name}}_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
