-module(shop).
-export([cost/1, total1/1, total2/1, total3/1, test/0]).

cost(orange) -> 5;
cost(newspaper) -> 8;
cost(apple) -> 2;
cost(pear) -> 9;
cost(milk) -> 7.

% Using recursion
total1([]) -> 0;
total1([{Item, Count} | T]) -> cost(Item) * Count + total1(T).

% Using map
total2(L) -> fun_basics:sum(fun_basics:map(fun({Item, Count}) -> cost(Item) * Count end, L)).

% Using list comprehension
total3(L) -> fun_basics:sum([cost(Item) * Count || {Item, Count} <- L]).

test() ->
  0 = total1([]),
  0 = total2([]),

  L = [{apple, 2}, {orange, 3}, {milk, 1}],
  Total = total1(L),
  Total = total2(L),
  Total = total3(L),
  'tests passed'.
