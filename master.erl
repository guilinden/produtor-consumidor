-module(master).
-export([init/0,criar_produtores/3,criar_consumidores/3]).

init() ->
  {ok, [Numero_Produtores]} = io:fread("Informe o numero de produtores : ", "~d"),
  {ok, [Numero_Consumidores]} = io:fread("Informe o numero de consumidores : ", "~d"),
  {ok, [Tamanho_buffer]} = io:fread("Informe o tamanho do Buffer : ", "~d"),
  Buffer = spawn(buffer, init, [Tamanho_buffer]),
  criar_produtores(1, Numero_Produtores, Buffer),
  criar_consumidores(1, Numero_Consumidores, Buffer).
 
criar_produtores(Id_Produtor, Numero_Produtores, Buffer) ->
  if Id_Produtor =< Numero_Produtores ->
		spawn(produtor, init, [Buffer, Id_Produtor]),
		criar_produtores(Id_Produtor + 1, Numero_Produtores, Buffer);
	true ->
		io:format("Produtores criados ~n",[])
  end.
  
criar_consumidores(Id_Consumidor, Numero_Consumidores, Buffer) ->
  if Id_Consumidor =< Numero_Consumidores ->
		spawn(consumidor, init, [Buffer, Id_Consumidor]),
		criar_consumidores(Id_Consumidor+ 1, Numero_Consumidores, Buffer);
	true ->
		io:format("Consumidores criados ~n",[])
  end.
  




