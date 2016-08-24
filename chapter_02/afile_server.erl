-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
  receive
    % ls
    {Client, ls} ->
      Client ! {self(), file:list_dir(Dir)};
    % get_file
    {Client, {get_file, File}} ->
      FullName = filename:join(Dir, File),
      Client ! {self(), file:read_file(FullName)};
    % put_file
    {Client, {put_file, File, Contents}} ->
      FullName = filename:join(Dir, File),
      Client ! {self(), file:write_file(FullName, Contents)}
  end,
  loop(Dir).
