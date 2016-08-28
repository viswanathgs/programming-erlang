-module(shop).
-export([cost/1, total1/1, total2/1, test/0]).

cost(orange) -> 5;
cost(newspaper) -> 8;
cost(apple) -> 2;
cost(pear) -> 9;
cost(milk) -> 7.

total1([]) -> 0;
total1([{Item, Count} | T]) -> cost(Item) * Count + total1(T).

total2(L) -> fun_basics:sum(fun_basics:map(fun({Item, Count}) -> cost(Item) * Count end, L)).

test() ->
  0 = total1([]),
  0 = total2([]),
  26 = total1([{apple, 2}, {orange, 3}, {milk, 1}]),
  26 = total2([{apple, 2}, {orange, 3}, {milk, 1}]),
  'tests passed'.
