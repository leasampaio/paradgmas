% insertion_sort  Caso base: uma lista vazia ou com apenas um elemento já está ordenada.
insertion_sort([], []).
insertion_sort([H|T], Sorted) :-
    insertion_sort(T, SortedTail), % Ordena a cauda da lista.
    insert(H, SortedTail, Sorted). % Insere a cabeça no local correto.

% Caso base para a inserção: inserir um elemento em uma lista vazia resulta em uma lista com apenas este elemento.
insert(X, [], [X]).
% Caso: insere X antes de Y se X for menor ou igual a Y.
insert(X, [Y|T], [X,Y|T]) :- X =< Y.
% Caso recursivo: X é maior que Y, insere X na cauda.
insert(X, [Y|T], [Y|SortedTail]) :-
    X > Y,
    insert(X, T, SortedTail).