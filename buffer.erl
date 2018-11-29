-module(buffer).
-export([init/1, listen/2, output/1]).

init(Tamanho_buffer) ->
  io:format("Buffer created~n"),
  BufferArray = [],
  listen(Tamanho_buffer, BufferArray).

listen(MaxSize, BufferArray) ->
  receive 
  
	{consumir, Id_consumidor} ->
      if length(BufferArray) > 0 ->
          [Primeiro_item | Resto_array] = BufferArray,
          Id_consumidor ! {removido,Primeiro_item},
          output(Resto_array),
          listen(MaxSize, Resto_array);
        true ->
          Id_consumidor ! vazio,
          listen(MaxSize, BufferArray)
      end;

    {inserir, Id_produtor, Item} ->
      if length(BufferArray) < MaxSize ->
          Copia_buffer = lists:append(BufferArray, [Item]),
          Id_produtor ! inserido,
          output(Copia_buffer),
          listen(MaxSize, Copia_buffer);
        true ->
          Id_produtor ! cheio,
          listen(MaxSize, BufferArray)
      end


  end.


output(Buffer) ->
  io:format(" ~n"),
  if length(Buffer) > 0 ->
	[Primeiro_item | Resto_array] = Buffer,
	io:format("~p ",[Primeiro_item]),
	output(Resto_array);
	
	true ->
		io:format("~n")
  end.
  
	