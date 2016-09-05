-module(math_functions).
-export([test/0, even/1, odd/1, filter/2, split1/1, split2/1]).

% Exercise 5
even(N) -> (N rem 2) =:= 0.
odd(N) -> (N rem 2) =:= 1.

% Exercise 6
filter(F, L) -> [X || X <- L, F(X)].

% Exercise 7

% Even-Odd split using accumulators
split1(L) -> split_acc(L, [], []).
split_acc([H|T], Evens, Odds) ->
  case even(H) of
    true -> split_acc(T, [H|Evens], Odds);
    false -> split_acc(T, Evens, [H|Odds])
  end;
split_acc([], Evens, Odds) ->
  {lists:reverse(Evens), lists:reverse(Odds)}.

% Even-Odd split using filter
split2(L) ->
  Evens = filter(fun(X) -> even(X) end, L),
  Odds = filter(fun(X) -> odd(X) end, L),
  {Evens, Odds}.

test() ->
  {false, true, true, false} = {even(1), even(2), odd(1), odd(2)},

  [2, 4, 6] = filter(fun(X) -> even(X) end, lists:seq(1, 6)),
  [1, 3, 5] = filter(fun(X) -> odd(X) end, lists:seq(1, 6)),

  {[2, 4], [1, 3]} = split1(lists:seq(1, 4)),
  {[2, 4], [1, 3]} = split2(lists:seq(1, 4)),

  'tests passed'.
