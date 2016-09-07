-module(try_test).
-export([generate_exception/1, catcher/1, demo1/0, demo2/0, sqrt/1, demo3/0, test/0]).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).

% 6.2 Trapping an exception with try...catch
catcher(N) ->
  try generate_exception(N) of
    Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X -> {N, caught, exited, X};
    error:X -> {N, caught, error, X}
  end.

demo1() ->
  [catcher(N) || N <- lists:seq(1, 6)].

% 6.3 Trapping an exception with catch
demo2() ->
  [{N, (catch generate_exception(N))} || N <- lists:seq(1, 6)].

% 6.4 Programming style with exceptions
sqrt(N) when N < 0 ->
  error({sqrtNegativeArg, N});
sqrt(N) ->
  math:sqrt(N).

% Stack traces
demo3() ->
  try generate_exception(100)
  catch
    error:Msg -> {Msg, erlang:get_stacktrace()}
  end.

test() ->
  [{1,normal,a},
   {2,caught,thrown,a},
   {3,caught,exited,a},
   {4,normal,{'EXIT',a}},
   {5,caught,error,a},
   {6,caught,error,function_clause}] = demo1(),

  demo2(),

  SqrtCatcher = fun(N) ->
    try sqrt(N)
    catch
      error:Msg -> Msg
    end
  end,
  2.0 = SqrtCatcher(4),
  {sqrtNegativeArg, -4} = SqrtCatcher(-4),
  
  'tests passed'.
