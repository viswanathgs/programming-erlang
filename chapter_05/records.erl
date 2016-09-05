-module(records).
-export([test/0]).
-include("records.hrl").

% Pattern Matching Records in Functions
todo_to_list(#todo{status=done, who=Name} = R) -> [Name, "Done"];
todo_to_list(#todo{who=Name} = R) -> [Name, "Not Done"].

test() ->
  R1 = #todo{},
  vish = R1#todo.who,
  reminder = R1#todo.status,

  R2 = #todo{text="code erlang", status=done},
  #todo{status=Status, text=Text} = R2,
  done = Status,
  "code erlang" = Text,

  [vish, "Not Done"] = todo_to_list(R1),
  [vish, "Done"] = todo_to_list(R2),

  'tests passed'.
