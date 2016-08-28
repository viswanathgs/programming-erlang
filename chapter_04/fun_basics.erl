-module(fun_basics).
-export([map/2, filter/2, sum/1, test/0]).

map(_, []) -> [];
map(F, [H|T]) -> [F(H) | map(F, T)].

filter(_, []) -> [];
filter(Pred, [H|T]) ->
  case Pred(H) of
    true -> [H | filter(Pred, T)];
    false -> filter(Pred, T)
  end.

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I+1, Max, F)].

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

test() ->
  % Funs
  Double = fun(X) -> 2*X end,
  10 = Double(5),

  Hypot = fun(X, Y) -> math:sqrt(X*X + Y*Y) end,
  5.0 = Hypot(3, 4),

  ConvTemperature = fun({celcius, C}) -> {fahrenheit, 32 + C * 9 / 5};
                       ({fahrenheit, F}) -> {celcius, (F - 32) * 5 / 9}
                    end,
  {celcius, 32.0} = ConvTemperature(ConvTemperature({celcius, 32.0})),
  {fahrenheit, 90.0} = ConvTemperature(ConvTemperature({fahrenheit, 90.0})),

  % Funs as arguments
  [2, 4, 6, 8] = map(fun(X) -> 2*X end, [1, 2, 3, 4]),
  [2, 4] = filter(fun(X) -> (X rem 2) =:= 0 end, [1, 2, 3, 4]),

  % Funs as return values
  IsMember = fun(List) -> (fun(Item) -> lists:member(Item, List) end) end,
  IsFruit = IsMember([apple, banana, orange]),
  true = IsFruit(apple),
  false = IsFruit(shoe),

  [apple, orange] = filter(IsFruit, [dog, apple, shoe, orange, tree]),

  Mult = fun(Times) -> (fun(X) -> Times * X end) end,
  Triple = Mult(3),
  15 = Triple(5),

  % Control abstractions
  [1, 4, 9, 16, 25] = for(1, 5, fun(X) -> X*X end), 

  0 = sum([]),
  6 = sum([1, 2, 3]),

  'tests passed'.
