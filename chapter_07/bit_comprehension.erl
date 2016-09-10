-module(bit_comprehension).
-export([test/0]).

test() ->
  B = <<16#5f>>, 

  ListB = [X || <<X:1>> <= B],
  [0, 1, 0, 1, 1, 1, 1, 1] = ListB,

  BinB = << <<X>> || <<X:1>> <= B >>,
  <<0, 1, 0, 1, 1, 1, 1, 1>> = BinB,

  BinB = list_to_binary(ListB),
  
  'tests passed'.
