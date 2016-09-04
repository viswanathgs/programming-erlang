-module(list_comprehension).
-export([test/0, qsort/1, pythag_triplets/1, permutations/1]).

% List comprehensions / generators

% Quicksort
qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot]) ++
  [Pivot] ++ 
  qsort([X || X <- T, X >= Pivot]).

% Pythagorean triplets
pythag_triplets(N) ->
  [ {A, B, C} ||
      A <- lists:seq(1,N),
      B <- lists:seq(1,N),
      C <- lists:seq(1,N),
      A+B+C =< N,
      A*A + B*B =:= C*C
  ].

% String permutations
permutations("") -> [""];
permutations(L) -> [[H|T] || H <- L, T <- permutations(L--[H])].

test() ->
  [] = qsort([]),
  [1, 2, 3] = qsort([1, 2, 3]),
  [1, 2, 3, 3, 4, 5, 6] = qsort([5, 3, 4, 1, 2, 3, 6]),

  [] = pythag_triplets(1),
  [{3, 4, 5}, {4, 3, 5}] = pythag_triplets(16),

  [""] = permutations(""),
  ["abc", "acb", "bac", "bca", "cab", "cba"] = permutations("abc"), 

  'tests passed'.
