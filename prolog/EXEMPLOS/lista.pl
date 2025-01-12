% Escreva as cláusulas para concatenar duas listas.

concatenar([], L2, L2) :- !.
concatenar([H|T], L, [H|R]) :- 
    concatenar(T,L,R).