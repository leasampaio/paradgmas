fat1(0,1).
fat1(N,F) :- N1 is N-1, fat1(N1,F1), F is N*F1.
