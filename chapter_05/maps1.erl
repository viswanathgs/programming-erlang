-module(maps1).
-export([test/0, count_characters/1, map_search_pred/2]).

% Counts the number of occurrences of each character in a string.
% Returns a map of the counts.
count_characters(Str) ->
  count_characters(Str, #{}).

count_characters([], Counts) ->
  Counts;
count_characters([H|T], Counts) ->
  case Counts of
    #{H := Count} -> count_characters(T, Counts#{H := Count+1});
    #{} -> count_characters(T, Counts#{H => 1})
  end.

% Exercise 2
map_search_pred(Map, Pred) ->
  list_search_pred(maps:to_list(Map), Pred).

list_search_pred([{Key, Val}|T], Pred) ->
  case Pred(Key, Val) of
    true -> {Key, Val};
    false -> list_search_pred(T, Pred)
  end;
list_search_pred([], _) ->
  not_found.

test() ->
  M1 = #{b => 2, a => 1},
  M2 = M1#{c => 3},
  #{c := C, a := A} = M2,
  1 = A,
  3 = C,

  M3 = M2#{c := 10},
  #{c := C1} = M3,
  10 = C1,

  #{} = count_characters(""),
  #{$h := 1, $e := 1, $l := 2, $o := 1} = count_characters("hello"),

  {2, 20} = map_search_pred(#{1 => 1, 3 => 30, 2 => 20, 4 => 4}, fun(K, V) -> K*10 =:= V end),
  not_found = map_search_pred(#{1 => 1, 4 => 4}, fun(K, V) -> K*10 =:= V end),

  'tests passed'.
