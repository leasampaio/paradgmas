 % > Maior que 
 % < Menor que
 % >= Maior ou igual
 % =< Menor ou igual
 % =:= Igual
 % \== Diferente
 % \+ Negação
 % is Atribuição
 % = Unificação
 % + Adição
 % - Subtração
 % * Multiplicação
 % / Divisão
 % // Divisão inteira
 % mod Resto da divisão
 % ^ Exponenciação
 % sqrt Raiz quadrada


maiorQueCem :- 
    write('Digite um número: '), nl, 
    read(X), 
    ( X > 100 -> write('O número é maior que 100.') ; write('O número é menor ou igual a 100.') ),
    nl.



