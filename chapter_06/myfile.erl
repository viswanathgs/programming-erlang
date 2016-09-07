-module(myfile).
-export([read_file/1, test/0]).

% Exercise 1
read_file(File) ->
  case file:read_file(File) of
    {ok, Contents} -> Contents;
    {error, Code} -> throw({Code, File, "Read failure"})
  end.

test() ->
  Catcher = fun(File) ->
    try read_file(File)
    catch
      throw:{enoent, File, Msg} -> Msg
    end
  end,

  _ = Catcher("myfile.erl"),

  "Read failure" = Catcher("missing_file"),

  'tests passed'.
