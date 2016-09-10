-module(mp3_sync).
-export([find_sync/2, is_header/2, get_word/2, unpack_header/1, decode_header/1]).

% Checks if pos N in Bin is the beginning of a valid MP3 header.
% Also checks two subsequent frames to reduce the probability of the
% MP3 sync frame being part of actual data.
find_sync(Bin, N) ->
  case is_header(Bin, N) of
    {ok, Len1, _} -> 
      case is_header(Bin, N + Len1) of
        {ok, Len2, _} ->
          case is_header(Bin, N + Len1 + Len2) of
            {ok, _, _} -> {ok, N};
            {error, _} -> find_sync(Bin, N+1)
          end;
        {error, _} -> find_sync(Bin, N+1)
      end;
    {error, _} -> find_sync(Bin, N+1)
  end.

is_header(Bin, N) ->
  unpack_header(get_word(Bin, N)).

% Given a bitstring Bin, extract the 4 byte word beginning at position N.
get_word(Bin, N) ->
  {_, <<Word:4/binary, _/binary>>} = split_binary(Bin, N),
  Word.

% Wrapper around decode_header to catch and return exceptions.
unpack_header(Header) ->
  try decode_header(Header)
  catch
    _:Msg -> {error, Msg}
  end.

% Decode the MP3 header (4 bytes) using binary pattern matching.
% MP3 header format: 11111111 111BBCCD EEEEFFGH IIJJKLMM.
decode_header(<<2#11111111111:11, B:2, C:2, D:1, E:4, F:2, G:1, Bits:9>>) ->
  FrameLength = 100, % Hard-coded for illustration
  {ok, FrameLength, {B, C, D, E, F, G, Bits}};
decode_header(_) ->
  exit(bad_header).
