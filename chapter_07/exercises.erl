-module(exercises).
-export([test/0, reverse_bytes/1, term_to_packet/1, packet_to_term/1, test_packetization/0, reverse_bits/1]).

% Exercise 1: Reverse bytes in a binary.
reverse_bytes(Bin) ->
  case is_binary(Bin) of
    true ->
      list_to_binary(lists:reverse([X || <<X:1/binary>> <= Bin]));
    false ->
      error(invalid_binary)
  end.

% Exercise 2
term_to_packet(Term) ->
  Bin = term_to_binary(Term),
  Size = byte_size(Bin),
  <<Size:32/unsigned-integer, Bin:Size/binary>>.

% Exercise 3
packet_to_term(Packet) ->
  <<Size:32/unsigned-integer, Bin:Size/binary>> = Packet,
  binary_to_term(Bin).

% Exercise 4
test_packetization() ->
  Packet = term_to_packet(hello_world),
  hello_world = packet_to_term(Packet),

  Size = byte_size(Packet),
  Size = 4 + byte_size(term_to_binary(hello_world)),

  'tests passed'.

% Exercise 5
reverse_bits(Bin) ->
  case bit_size(Bin) of
    0 -> Bin;
    _ -> 
      <<H:1/bits, T/bits>> = Bin,
      R = reverse_bits(T),
      <<R/bits, H:1/bits>>
   end.

test() ->
  ReverseBytes = fun(B) ->
    try reverse_bytes(B)  
    catch
      error:Msg -> Msg
    end
  end,
  <<30, 20, 10>> = ReverseBytes(<<10, 20, 30>>),
  invalid_binary = ReverseBytes(<<10, 20, 30:7>>),

  'tests passed' = test_packetization(),

  Bin = <<1:1, 0:1, 1:1, 1:1, 0:1>>,
  <<0:1, 1:1, 1:1, 0:1, 1:1>> = reverse_bits(Bin),
  Bin = reverse_bits(reverse_bits(Bin)),

  'tests passed'.
