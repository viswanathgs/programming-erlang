-module(exercises).
-export([test/0, tuple_to_list1/1, time_func/1, elapsed_seconds/2, cur_date_string/0]).

% Exercise 2
tuple_to_list1(T) -> tuple_to_list_helper(T, 1).

tuple_to_list_helper(T, Index) ->
  case Index =< tuple_size(T) of
    true -> [element(Index, T) | tuple_to_list_helper(T, Index+1)];
    false -> []
  end.

% Exercise 3
to_seconds({MegaSecs, Secs, MicroSecs}) ->
  1000000 * MegaSecs + Secs + MicroSecs / 1000000.0.

elapsed_seconds(Begin, End) ->
  to_seconds(End) - to_seconds(Begin).

time_func(F) ->
  Begin = now(),
  F(),
  End = now(),
  Elapsed = elapsed_seconds(Begin, End),
  io:format("Elapsed time = ~f seconds~n", [Elapsed]).

cur_date_string() ->
  {Year, Month, Day} = date(), 
  Date = [Month, Day, Year],
  Time = tuple_to_list(time()),
  io:format("~p/~p/~p ~p:~p:~p~n", Date ++ Time).

test() ->
  [] = tuple_to_list1({}),
  [1] = tuple_to_list1({1}),
  [1, a, "blah"] = tuple_to_list1({1, a, "blah"}),

  'tests passed'.
