-module(produtor).
-export([produzir/3, init/2]).

init(Buffer, Id_produtor) ->
	io:format("Produtor  ~w ~n",[Id_produtor]),
	produzir(Buffer,Id_produtor,0).

produzir(Buffer,Id_produtor,Cont) ->
	Novo_cont = Cont + 1,
	timer:sleep(rand:uniform(7)*100),
	Item = rand:uniform(200),
	Buffer ! {inserir,self(),Item},
	receive
		inserido ->
			io:format("Item ~p inserido pelo produtor ~p  Contador --> ~p ~n",[Item,Id_produtor,Novo_cont]),
			produzir(Buffer,Id_produtor,Novo_cont);
		
		cheio ->
			io:format("Buffer cheio"),
			produzir(Buffer,Id_produtor,Novo_cont)
	
	end.
