# https://swish.swi-prolog.org/ - online prolog interpreter
cidade(salvador).
cidade(brasilia).
pais(brasil).
estado(bahia).
capital(brasilia,brasil).
capital(salvador, bahia).


capital(X, bahia)
#X = salvador
capital(X, brasil)
#X = brasilia
cidade(X, brasil)
#X = salvador
cidade(X)
#X = salvador
#X = brasilia
pais(X)
#X = brasil
estado(X)
#X = bahia
capital(X, Y)
#X = salvador, Y = bahia
#X = brasilia, Y = brasil



gosta(vinho,X).
gosta(X, corona_virus)
