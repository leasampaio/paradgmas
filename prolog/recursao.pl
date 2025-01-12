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
herbivoro(X) :- come(X,grama).
pertence-cadeia-alimentar(X,Y) :-animal(X), come(X,Y).
pertence-cadeia-alimentar(X,Y) :-animal(X), come(X,Z), pertence-cadeia-alimentar(Z,Y).