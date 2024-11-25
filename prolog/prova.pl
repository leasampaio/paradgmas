% Caso base: se a lista de listas é vazia, o resultado é uma lista vazia.
mescleLL([], []).

% Caso base: se a lista de listas contém apenas uma lista, o resultado é essa lista.
mescleLL([L], L).

% Caso recursivo: mescla duas listas ordenadas e continua o processo com o restante.
mescleLL([L1, L2 | T], R) :-
    mescle2(L1, L2, M),         % Mescla as duas primeiras listas.
    mescleLL([M | T], R).       % Continua mesclando com as demais.

% Predicado auxiliar para mesclar duas listas ordenadas em uma única lista ordenada.
mescle2([], L, L).              % Se a primeira lista está vazia, o resultado é a segunda.
mescle2(L, [], L).              % Se a segunda lista está vazia, o resultado é a primeira.
mescle2([H1|T1], [H2|T2], [H1|R]) :-
    H1 =< H2,                   % Se o primeiro elemento de L1 é menor ou igual ao de L2.
    mescle2(T1, [H2|T2], R).    % Continua mesclando o restante.
mescle2([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,                    % Se o primeiro elemento de L1 é maior que o de L2.
    mescle2([H1|T1], T2, R).    % Continua mesclando o restante.
