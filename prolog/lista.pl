% Escreva as cláusulas para concatenar duas listas.

concatenar([], L2, L2) :- !.
concatenar([H|T], L, [H|R]) :- 
    concatenar(T,L,R).

% Escreva as cláusulas para concatenar duas listas, sendo que a segunda lista vem na frente.

concatenarInv(L2, [], L2) :- !.
concatenarInv(L, [H|T], [H|R]) :- 
    concatenarInv(L,T,R).


% Escreva as cláusulas para juntar duas listas, intercalando seus elementos.

minsturar([], L2, L2) :- !.
minsturar([H|T],[H2|T2],[H,H2|R]):-
    minsturar(T,T2,R).

% Misturar duas Listas 
minsturar([], L2, L2) :- !.
minsturar(L, [H|T], [H|R]) :- 
    minsturar(T,L,R).

% Escreva as cláusulas para concatenar uma lista de listas.

concatenarListas([], []) :- !.
concatenarListas([H|T], R) :- 
	concatenarListas(T, R1),
	concatenar(H, R1, R).

% Q5 - Adicionar final
adicionarFinal(X, [], [X]).
adicionarFinal(Y, [H|T], [H|R]):-
    adicionarFinal(Y, T, R).

% Q6 - Inverter
inverter([],[]) :- !.
inverter([H|T], R) :- inverter(T,H2), adicionarFinal(H,H2,R).

inverter([], []) :- !.
inverter([H|T], R) :- 
	inverter(T, R1),
	adicionarFinal(H, R1, R).

% Escreva em PROLOG as cláusulas mescleLL(+LL,?L),  que recebe uma lista de listas ordenadas (não vazia) e as mescla em um % única lista ordenada.  Por exemplo:

% ?- mescleLL([[1,3,5],[2,4,6],[0,7,8]],L).
% L = [0, 1, 2, 3, 4, 5, 6, 7, 8] .
% Caso base: quando LL é uma lista vazia, L é uma lista vazia.
mescleLL([], []).

% Caso recursivo: quando LL não é vazia, concatenar todas as listas e ordenar o resultado.
mescleLL(LL, L) :-
    concatenarListas(LL, L1),
    sort(L1, L).

% Cláusula para concatenar uma lista de listas.
concatenarListas([], []).
concatenarListas([H|T], R) :- 
    concatenarListas(T, R1),
    append(H, R1, R).