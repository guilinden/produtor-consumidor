-module(consumidor).
-export([consumir/3, init/2]).

init(Buffer, Id_consumidor) ->
	io:format("Consumidor  ~w ~n",[Id_consumidor]),
	consumir(Buffer,Id_consumidor,0).

consumir(Buffer,Id_consumidor,Cont) ->
	Novo_cont = Cont + 1,
	timer:sleep(rand:uniform(7)*100),
	Buffer ! {consumir,self()},
	receive
		{removido,Item_consumido} ->
			io:format("Item ~p excluido pelo consumidor ~p Contador --> ~p\n",[Item_consumido,Id_consumidor,Novo_cont]),
			consumir(Buffer,Id_consumidor,Novo_cont);
		
		vazio ->
			io:format("Buffer vazio ~n"),
			consumir(Buffer,Id_consumidor,Novo_cont)
	end.
