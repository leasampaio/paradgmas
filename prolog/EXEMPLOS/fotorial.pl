% fatorial
fatorial(0,1).
fatorial(X,Y) :- X > 0, X1 is X-1, fatorial(X1,Y1), Y is X*Y1.
% fatorial(5,Y).