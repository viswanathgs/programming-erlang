-module(lib_misc).
-export([test/0, qsort/1, pythag_triplets/1, permutations/1, max1/2,
         odds_and_evens1/1, odds_and_evens2/1, my_tuple_to_list/1]).

% 4.5 List comprehensions / generators

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

% 4.7 Guards
%
% A guard is a series of guard expressions, separated by commas (,). The guard
% GuardExpr1, GuardExpr2, …, GuardExprN is true if all the guard expressions—GuardExpr1,
% GuardExpr2, …—evaluate to true.
%
% A guard sequence is either a single guard or a series of guards, separated by
% semicolons (;). The guard sequence G1; G2; ...; Gn is true if at least one of the
% guards—G1, G2, …—evaluates to true.
max1(X, Y) when X > Y -> X;
max1(X, Y) -> Y.

% 4.10 Accumulators

% Function to separate a list of integers into odds and evens.
% This traverses the list twice.
odds_and_evens1(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

% Using accumulators, the list is traversed only once.
odds_and_evens2(L) -> odds_and_evens_acc(L, [], []). 
% Accumulate the result to the head of the result and then later
% reverse the result. This is more performant than appending to
% the end of the list.
odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) -> 
  {lists:reverse(Odds), lists:reverse(Evens)}.

test() ->
  [] = qsort([]),
  [1, 2, 3] = qsort([1, 2, 3]),
  [1, 2, 3, 3, 4, 5, 6] = qsort([5, 3, 4, 1, 2, 3, 6]),

  [] = pythag_triplets(1),
  [{3, 4, 5}, {4, 3, 5}] = pythag_triplets(16),

  [""] = permutations(""),
  ["abc", "acb", "bac", "bca", "cab", "cba"] = permutations("abc"), 

  5 = max1(5, 5),
  10 = max1(10, 5),
  10 = max1(5, 10),

  {[1, 3, 5], [2, 4, 6]} = odds_and_evens1(lists:seq(1, 6)),
  {[1, 3, 5], [2, 4, 6]} = odds_and_evens2(lists:seq(1, 6)),

  'tests passed'.
