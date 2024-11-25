% Q1 - Concatenar
%
concatenar([],L,L).
concatenar([X|R], L, [X|W]) :- concatenar(R,L,W).


% Q2 - Concatenar Inv

concatenarInv(L1,L2,L3) :- concatenar(L2,L1,L3).

% v2
concInv(L,[],L) :- !.
concInv(L,[X|R],[X|W]) :- concInv(L,R,W).




% Q3 - Concatenar lista de listas

concatenarLL([],[]).
concatenarLL([X],X).
concatenarLL([X,Y|R],T) :- concatenar(X,Y,W),
                           concatenarLL([W|R],T),!.

concatenar([],[]).
concatenar([X],X).
concatenar([X,Y|R],T) :- concatenar(X,Y,W),
                           concatenar([W|R],T),!.

concLL([],[]).
concLL([L|RL],LR) :- concLL(RL,LRI), concatenar(L,LRI,LR).



% Q4 - Juntar intercalando duas listas

juntar([],[],[]).
juntar([],[Y|YR],[Y|YR]).
juntar([X|XR],[],[X|XR]).
juntar([X|XR],[Y|YR],[X,Y|R]) :- juntar(XR,YR,R).


intercalar([],L,L) :- !.
intercalar(L,[],L) :- !.
intercalar([X|XR],[Y|YR],[X,Y|R]) :- intercalar(XR,YR,R).


% Q5 - Adicionar final

adicionarFinal(E,[],[E]).
adicionarFinal(E, [X|R], [X|W]) :- adicionarFinal(E,R,W).

% Q6 - Inverter

inverter([],[]) :- !.
inverter([X|R],T) :- inverter(R,W), adicionarFinal(X,W,T),!.


inverter2(L,Linv) :- invaux(L,[],Linv).

invaux([],La,La).
invaux([X|R],La,Linv) :- invaux(R,[X|La],Linv).


% Q7 - Inverte LG

inverterLG(L,Linv) :- inv3(L,[],Linv).

inv3([],A,A).
inv3([X|R],A,LI) :- is_list(X),inv3(X,[],XI),inv3(R,[XI|A],LI),!.
inv3([X|R],A,LI) :- inv3(R,[X|A],LI).


is_list2([]).
is_list2([_|_]).


% Q8 - Parear
%

parear(_,[],[]).
parear(E,[X|R],[[E,X]|W]) :- parear(E,R,W).


% Q9 - Pares
%
pares([],[]).
pares([_],[]).
pares([X,Y|R],[[X,Y]|LL]) :-
     parear(X,R,L1),parear(Y,R,L2),pares(R,L3),concatenar([L1,L2,L3],LL).

%% Solu��o alternativa que retorna todos os pares, um a um

pares2([X,Y|_],[X,Y]).
pares2([X,_|R],W) :- parear2(X,R,W).
pares2([_,Y|R],W) :- parear2(Y,R,W).
pares2([_,_|R],W) :- pares2(R,W).

parear2(E,[X|_],[E,X]).
parear2(E,[_|R],W) :- parear2(E,R,W).


% Q10 - Permutar
%

permutar([],[]).
permutar(List,[H|Perm]):- remova(H,List,Rest),permutar(Rest,Perm).

remova(X,[X|T],T).
remova(X,[H|T],[H|NT]):- remova(X,T,NT).

% Q11- Conjunto
%

conjunto([]).
conjunto([X|R]) :- \+ member(X,R), conjunto(R).

% Q12 - Prefixo
%

prefixo([],_).
prefixo([X|R1],[X|R2]) :- prefixo(R1,R2).

% Q13 - Subsequencia
%

subsequencia([],_) :- !.
subsequencia(L1,L2) :- prefixo(L1,L2).
subsequencia(L1,[_|R]) :- subsequencia(L1,R).

% Q 14 - Mescle
%
mescle([],L2,L2) :- !.
mescle(L1,[],L1) :- !.
mescle([E1|R1], [E2|R2], [E1|W]) :- E1 =< E2, mescle(R1, [E2|R2], W),!.
mescle([E1|R1], [E2|R2], [E2|W]) :- mescle([E1|R1], R2, W).

% Q 15 - Merge Sort
%

% primeiro escreveremos o predicado para dividir uma lista
%  em duas lista de tamanhos similares
% divide(L+,L1?,L2?).

divide([],[],[]) :- !.
divide([E],[E],[]) :- !.
divide([E1,E2|R], [E1|R1], [E2|R2]) :- divide(R,R1,R2).

mergesort([],[]) :- !.
mergesort([E],[E]) :- !.
mergesort(L,LO) :- divide(L,L1,L2),
                   mergesort(L1,LO1),
                   mergesort(L2,LO2),
                   mescle(LO1,LO2,LO).

% Q 16 - Mescle Vers�o 2
%
mescle2([],L2,_,L2) :- !.

mescle2(L1,[],_,L1) :- !.

mescle2([E1|R1], [E2|R2], FC, [E1|W]) :- call(FC,E1,E2),
                                         mescle2(R1, [E2|R2], FC, W),!.

mescle2([E1|R1], [E2|R2], FC , [E2|W]) :- mescle2([E1|R1], R2, FC, W).



% Q 16 - Mescle Vers�o 3
%

mescle3([],L2,_,_,L2) :- !.

mescle3(L1,[],_,_,L1) :- !.

mescle3([E1|R1], [E2|R2], FC, CC, [E1|W]) :-
                                         call(CC,E1,EC1),
                                         call(CC,E2,EC2),
                                         call(FC,EC1,EC2),
                                         mescle3(R1, [E2|R2], FC, CC, W),!.

mescle3([E1|R1], [E2|R2], FC , CC, [E2|W]) :- mescle3([E1|R1], R2, FC, CC, W).


% Q 17 - MergeSort vers�o 3
%

mergesort3(L,LO) :- mergesort3(L,=<,identidade,LO).

identidade(X,X).


mergesort3([],_,_,[]) :- !.
mergesort3([E],_,_,[E]) :- !.
mergesort3(L,FC,CC,LO) :- divide(L,L1,L2),
                          mergesort3(L1,FC,CC,LO1),
                          mergesort3(L2,FC,CC,LO2),
                          mescle3(LO1,LO2,FC,CC,LO).


first([E|_],E).