-module(afile_client).
-export([ls/1, get_file/2, put_file/3]).

% ls
ls(Server) ->
  Server ! {self(), list_dir},
  receive
    {Server, FileList} -> FileList
  end.

% get_file
get_file(Server, File) ->
  Server ! {self(), {get_file, File}},
  receive
    {Server, Contents} -> Contents
  end.

% put_file
put_file(Server, File, Contents) ->
  Server ! {self(), {put_file, File, Contents}},
  receive
    {Server, Result} -> Result
  end.
