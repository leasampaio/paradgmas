read(X).
% Lê uma variável X do teclado.

write(joao).
% Escreve "joao" na tela.

% impressão nova linha
nl
\n
\l

%  Retorna ao inicio da linha
\r

% tabulação
\t

% imprime o simbolo de porcentagem
\%


atom(joao).
% Verifica se joao é um átomo.

atom(12).
% Verifica se 12 é um átomo.

number(12).
% Verifica se 12 é um número.

integer(12).
% Verifica se 12 é um inteiro.

is_list([1,2,3]).
% Verifica se [1,2,3] é uma lista.

start() :- write('Hello World!'), nl.
% Define um novo comando start que escreve "Hello World!" na tela.

start() :- write('Digite o valor de X:'), nl, read(X), write('O valor de X é: '), write(X), nl.
% Define um novo comando start que lê um valor X do teclado e escreve o valor de X na tela.

% Fatos
homem(X).
genitor(X,Y).



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

% Regras
% se
:-
% e 
,
% ou
;
% CONCLUSAO (+ARG) :- CONDIÇÃO1(+ARG) CONECTIVO CONDIÇÃO2(+ARG) ... CONDIÇÃO_N(+ARG).



aluno(joao, calculo).
aluno(maria, calculo).
aluno(joel, programacao).
aluno(joel, estrutura).
frequenta(joao, puc).
frequenta(maria, puc).
frequenta(joel, ufrj).
professor(carlos, calculo).
professor(ana_paula, estrutura).
professor(pedro, programacao).
funcionario(pedro, ufrj).
funcionario(ana_paula, puc).
funcionario(carlos, puc).
alunos_professores(A,P):- professor(P,Materias) , aluno(A,Materias).
alunos_associados(Alunos,Universidades):- frequenta(Alunos, Universidades).
professores_associados(Professores, Universidades):- funcionario(Professores, Universidades).
associados(Professores, Universidades):- alunos_associados(Professores, Universidades) ; professores_associados(Professores, Universidades).

listing(aluno/2)
% Lista os fatos do predicado aluno/2.
% aluno(joao, calculo).
%  aluno(maria, calculo).
%  aluno(joel, programacao).
%  aluno(joel, estrutura).
% corte
