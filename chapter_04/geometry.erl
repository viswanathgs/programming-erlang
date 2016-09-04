-module(geometry).
-export([area/1, perimeter/1, test/0]).

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius;
area({right_triangle, Base, Height}) -> 1 / 2.0 * Base * Height.

perimeter({rectangle, Width, Height}) -> 2 * (Width + Height);
perimeter({square, Side}) -> 4 * Side;
perimeter({circle, Radius}) -> 2 * 3.14159 * Radius;
perimeter({right_triangle, Base, Height}) ->
  Hypot = fun(X, Y) -> math:sqrt(X*X + Y*Y) end,
  Base + Height + Hypot(Base, Height).

test() ->
  12 = area({rectangle, 3, 4}),
  100 = area({square, 10}),
  25.0 = area({right_triangle, 10, 5}),

  14 = perimeter({rectangle, 3, 4}),
  40 = perimeter({square, 10}),
  12.0 = perimeter({right_triangle, 3, 4}),

  'tests passed'.
