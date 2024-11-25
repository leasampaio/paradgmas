animal(urso).
animal(peixe).
animal(peixinho).
animal(lince).
animal(raposa).
animal(coelho).
animal(veado).
animal(guaxinim).
planta(alga).
planta(grama).

come(urso, peixe).
come(lince, veado).
come(urso, raposa).
come(urso, veado).
come(peixe, peixinho).
come(peixinho, alga).
come(guaxinim, peixe).
come(raposa, coelho).
come(coelho, grama).
come(veado, grama).
come(urso, guaxinim).
% O que o urso come?
% ?- come(urso, X).
% O que come o peixe?
% ?- come(X, peixe).
% O urso come planta?
% ?- come(urso, planta).

% Escreva uma regra que defina um animal como herbívoro se ele come grama.

herbivoro(X) :- come(X,grama).


% Escreva uma regra que defina um animal como pertencente a uma cadeia alimentar se ele come outro animal que pertence a cadeia alimentar.
pertence-cadeia-alimentar(X,Y) :-animal(X), come(X,Y).
pertence-cadeia-alimentar(X,Y) :-animal(X), come(X,Z), pertence-cadeia-alimentar(Z,Y).