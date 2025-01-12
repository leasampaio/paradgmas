#lang racket
(define a 10)
(define (b x)
  (* x 2))
(b 5)
(define (fatorial x)
  (if (<= x 1)
      1
      (* (fatorial (- x 1)) x)))
(fatorial 5)
(fatorial 1)

;soma números


(define (sum lista)
  (cond
    [(empty? lista) 0]
    [else (+ (first lista) (sum (rest lista)))]))

(append '(a b c) '(d e f))
;; Função para gerar contagem inversa de N até 1
(define (contagem-inversa n)
  (if (<= n 0)           ; Caso base: se N <= 0, retorna uma lista vazia
      '()
      (cons n            ; Adiciona N à lista
            (contagem-inversa (- n 1))))) ; Chamada recursiva com N-1


(displayln (contagem-inversa 5)) 



;; Implementação recursiva da função append
(define (append-recursivo lst1 lst2)
  (if (null? lst1)          ; Caso base: se a primeira lista está vazia
      lst2                  ; Retorna a segunda lista
      (cons (car lst1)      ; Adiciona o primeiro elemento de lst1
            (append-recursivo (cdr lst1) lst2)))) ; Chamada recursiva com o resto de lst1

;; Teste com duas listas
(define lista1 '(1 2 3))
(define lista2 '(4 5 6))

(displayln (append-recursivo lista1 lista2)) ; Resultado esperado: '(1 2 3 4 5 6)


;; Função para gerar contagem crescente de 1 até N
(define (contagem-crescente n)
  (if (<= n 0)           ; Caso base: se N <= 0, retorna uma lista vazia
      '()
      (append-recursivo (contagem-crescente (- n 1)) ; Chamada recursiva para gerar a lista de 1 até N-1
              (list n))))                  ; Adiciona N no final da lista

;; Teste com N = 5
(displayln (contagem-crescente 5)) ; Resultado esperado: '(1 2 3 4 5)


;; Função para aplanar uma lista genérica
(define (aplanar lg)
  (cond
    [(null? lg) '()]                      ; Caso base: se a lista está vazia, retorna uma lista vazia
    [(list? (car lg))                     ; Se o primeiro elemento for uma lista
     (append (aplanar (car lg))           ; Aplana a sublista recursivamente
             (aplanar (cdr lg)))]         ; Continua aplanando o restante da lista
    [else                                 ; Caso contrário, o primeiro elemento não é uma lista
     (cons (car lg) (aplanar (cdr lg)))])) ; Adiciona o elemento à lista aplanada recursivamente

;; Teste com uma lista genérica
(displayln (aplanar '(a (b c (a)) ((a)) (d a)))) ; Resultado esperado: '(a b c a a d a)


;; Função para calcular a profundidade máxima de uma lista genérica
(define (prof-ll generic-list)
  (cond
    [(not (list? generic-list)) 0]              ; Caso base: se não for uma lista, a profundidade é 0
    [(null? generic-list) 1]                   ; Uma lista vazia tem profundidade 1 (representa uma camada)
    [else
     (+ 1                                       ; Conta a profundidade da camada atual
        (foldl max 0                            ; Usa foldl para encontrar a maior profundidade
              (map prof-ll generic-list)))]))   ; Calcula recursivamente a profundidade de cada elemento

;; Teste com a lista genérica
(displayln (prof-ll '((a b c) (e (f g (h))) d))) ; Resultado esperado: 4
(displayln (prof-ll '((a (b (c))))))             ; Resultado esperado: 4
(displayln (prof-ll 'a))                         ; Resultado esperado: 0
(displayln (prof-ll '()))                        ; Resultado esperado: 1



;; Função principal merge-sort2
(define (merge-sort2 lst #:f (f <) #:k (k identity))
  ;; Função auxiliar para intercalar duas listas ordenadas
  (define (merge left right)
    (cond
      [(empty? left) right] ; Se a lista esquerda está vazia, retorna a direita
      [(empty? right) left] ; Se a lista direita está vazia, retorna a esquerda
      [else
       (if (f (k (first left)) (k (first right))) ; Compara os elementos usando f e k
           (cons (first left) (merge (rest left) right)) ; Adiciona o menor elemento e continua
           (cons (first right) (merge left (rest right))))])) ; Adiciona o menor elemento e continua

  ;; Caso base: listas de tamanho 0 ou 1 já estão ordenadas
  (if (or (empty? lst) (empty? (rest lst)))
      lst
      ;; Divide a lista em duas partes e realiza merge sort recursivamente
      (let* ([mid (quotient (length lst) 2)]
             [left (take lst mid)]
             [right (drop lst mid)])
        (merge (merge-sort2 left #:f f #:k k)
               (merge-sort2 right #:f f #:k k)))))

;; Testes com exemplos

;; Exemplo 1: Ordenação padrão de números
(displayln (merge-sort2 '(3 4 7 8 10 2 1 9 5 6)))  ; Resultado esperado: '(1 2 3 4 5 6 7 8 9 10)

;; Exemplo 2: Ordenação de listas de diferentes tamanhos com função de comparação >= e extração de chave length
(displayln (merge-sort2 '((3 4) (7 8 10 2 1) (9 5 6)) #:f >= #:k length))
  ; Resultado esperado: '((7 8 10 2 1) (9 5 6) (3 4))


(define (concatenar1 l1 l2)
  (cond
    [(empty? l1) l2]   ; Se a primeira lista estiver vazia, retorna a segunda lista
    [else (cons (first l1) (concatenar1 (rest l1) l2))]))  ; Caso contrário, cons a cabeça de l1 com a concatenação das caudas

;; Teste
(displayln (concatenar1 '(a b c) '(d e f g h))) ; Resultado esperado: '(a b c d e f g h)

(define (concatenarInv l1 l2)
  (cond
    [(empty? l2) l1]   ; Se a segunda lista estiver vazia, retorna a primeira lista
    [else (cons (first l2) (concatenarInv l1 (rest l2)))])) ; Caso contrário, cons a cabeça de l2 com a concatenação de l1 e a cauda de l2

;; Teste
(displayln (concatenarInv '(a b c) '(d e f g h))) ; Resultado esperado: '(d e f g h a b c)

(define (concatenar2 ll)
  (cond
    [(empty? ll) '()]  ; Se a lista de listas estiver vazia, retorna uma lista vazia
    [else (concatenar1 (first ll) (concatenar2 (rest ll)))]))  ; Concatenar a primeira lista com o resultado da concatenação das demais listas

;; Teste
(displayln (concatenar2 '((a b) (c) (d e f g)))) ; Resultado esperado: '(a b c d e f g)

; Escreva uma função para concatenar N listas.
; a) Em RACKET: (concatenar3 l ...)
; Por exemplo:
; > (concatenar3 '(a b) '(c) '(d e f g))
; Deve retornar:
; (a b c d e f g)

(define (concatenar3 . l)
  (define (aux concatenated lsts)
    (cond
      [(empty? lsts) concatenated]  ; Se não houver mais listas, retorna a lista concatenada
      [else (aux (concatenar1 (first lsts) concatenated) (rest lsts))])) ; Concatena a primeira lista com a acumulada

  ;; Função auxiliar para concatenar duas listas
  (define (concatenar1 l1 l2)
    (cond
      [(empty? l1) l2]   ; Se a primeira lista estiver vazia, retorna a segunda lista
      [else (cons (first l1) (concatenar1 (rest l1) l2))]))  ; Caso contrário, cons a cabeça de l1 com a concatenação da cauda de l1 com l2
  
  ;; Inicia a recursão com uma lista vazia como resultado acumulado
  (aux '() l))

;; Teste
(displayln (concatenar3 '(a b) '(c) '(d e f g))) ; Resultado esperado: '(a b c d e f g)


; Escreva as cláusulas para juntar duas listas, intercalando seus elementos.
; b) Em Racket : (juntar l1 l2)
; Por exemplo:
; > (juntar '(a b c) '(d e f g h))
; Deve retornar:
; (a d b e c f g h)


(define (juntar l1 l2)
  (cond
    [(empty? l1) l2]    ; Se l1 estiver vazia, retorna l2
    [(empty? l2) l1]    ; Se l2 estiver vazia, retorna l1
    [else
     (cons (first l1) (cons (first l2) (juntar (rest l1) (rest l2))))]))  ; Intercala o primeiro de l1 e o primeiro de l2, e faz recursão

;; Teste
(displayln (juntar '(a b c) '(d e f g h))) ; Resultado esperado: '(a d b e c f g h)


; Escreva uma função para adicionar um elemento ao final de uma lista.
; a) Em RACKET: (adicionarFinal e l)
; Por exemplo:
; > (adicionarFinal 'z '(a b c))
; Deve retornar:
; (a b c z)

(define (adicionarFinal e l)
  (cond
    [(empty? l) (list e)]  ; Se a lista estiver vazia, retorna uma lista contendo apenas o elemento
    [else (cons (first l) (adicionarFinal e (rest l)))]))  ; Caso contrário, adiciona o elemento no final recursivamente

;; Teste
(displayln (adicionarFinal 'z '(a b c))) ; Resultado esperado: '(a b c z)


; Escreva uma função para inverter uma lista.
; a) Em RACKET: (inverter L)
; Por exemplo:
; > (inverter '(a b c))
; Deve retornar:
; (c b a)

(define (inverter L)
  (define (aux L acc)
    (cond
      [(empty? L) acc]  ; Se a lista estiver vazia, retorna o acumulador
      [else (aux (rest L) (cons (first L) acc))]))  ; Adiciona o primeiro elemento ao acumulador e faz a recursão sobre a cauda
  (aux L '()))  ; Chama a função auxiliar com a lista original e o acumulador vazio

;; Teste
(displayln (inverter '(a b c))) ; Resultado esperado: '(c b a)



; (displayln (inverter '(a b c))) ; Resultado esperado: '(c b a)
; Escreva uma função para criar uma lista intercalada de tamanho N, de dois elementos e1 e e2.
; a) Em RACKET: (intercala n e1 e2)
; Por exemplo:
; > (intercala 5 'x 'y)
; Deve retornar:
; (x y x y x)

(define (intercala n e1 e2)
  (define (aux n acc)
    (cond
      [(= n 0) acc]  ; Se n for 0, retorna o acumulador
      [else
       (aux (- n 1) (if (even? (- n 1)) (cons e1 acc) (cons e2 acc)))]))  ; Intercala e1 e e2 de acordo com a paridade do índice
  (reverse (aux n '())))  ; Inverte a lista para obter a ordem correta

;; Teste
(displayln (intercala 5 'x 'y)) ; Resultado esperado: '(x y x y x)


; Escreva uma função para criar uma lista intercalada de tamanho N, de M elementos eM.
; a) Em RACKET: (intercala2 n e ... )
; Por exemplo:
; > (intercala 5 'x 'y 'z)
; Deve retornar:
; (x y z x y)

(define (intercala2 n . e)
  (define (aux n acc lst)
    (cond
      [(= n 0) acc]  ; Se n for 0, retorna o acumulador
      [else
       (aux (- n 1) (cons (first lst) acc) (if (empty? (rest lst)) e (rest lst)))]))  ; Intercala os elementos, reinicia a lista quando atingir o final
  (reverse (aux n '() e)))  ; Inverte a lista para obter a ordem correta

;; Teste
(displayln (intercala2 5 'x 'y 'z))  ; Resultado esperado: '(x y z x y)

; Escreva a função parear que recebe um elemento E e uma lista L, e produz a lista de pares cujo primeiro elemento
; é E e o segundo elemento é um membro de L.
; a) Em RACKET: (parear e l)
; Por exemplo:
; > (parear 'x '(a b c))
; Deve retornar:
; ((x a) (x b) (x c))

(define (parear e l)
  (map (lambda (x) (list e x)) l))  ; Para cada elemento em l, cria um par (e, x)

;; Teste
(displayln (parear 'x '(a b c)))  ; Resultado esperado: '((x a) (x b) (x c))


; Escreva a função pares que recebe uma lista L e produz a lista de todos os pares de elementos de L.
; a) Em RACKET (pares l)
; Por exemplo:
; > (pares '(a b c d))
; Deve retornar:
; ((a b) (a c) (a d) (b c) (b d) (c d))

(define (pares l)
  (define (aux l acc)
    (cond
      [(empty? l) acc]  ; Se a lista estiver vazia, retorna o acumulador
      [else
       (aux (rest l) (append (map (lambda (x) (list (first l) x)) (rest l)) acc))]))  ; Para cada elemento restante em l, cria um par com o primeiro elemento de l
  (aux l '()))  ; Chama a função auxiliar com a lista original e um acumulador vazio

;; Teste
(displayln (pares '(a b c d)))  ; Resultado esperado: '((a b) (a c) (a d) (b c) (b d) (c d))

; Escreva as cláusulas para produzir todas as permutações dos elementos de uma lista.
; b) Em RACKET: (permutar L)
; Por exemplo:
; > (permutar '(1 2 3))
; Deve retornar:
; ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

(define (permutar L)
  (cond
    [(empty? L) '(())]  ; Caso base: a permutação de uma lista vazia é uma lista contendo a lista vazia
    [else
     (apply append
            (map (lambda (x)
                   (map (lambda (p) (cons x p)) (permutar (remove x L))))
                 L))]))  ; Para cada elemento de L, remove-o da lista e gera todas as permutações das subsequentes

;; Teste
(displayln (permutar '(1 2 3)))  ; Resultado esperado: '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

; Escreva a função que recebe uma lista e testa se ela tem elementos repetidos (pode ser interpretada como um
; conjunto).
; a) Em RACKET: (conjunto? L)
; Por exemplo:
; > (conjunto? '(a b c d))
; Deve retornar:
; #t
; > (conjunto? '(a b c d b))
; Deve retornar:
; #f


(define (conjunto? L)
  (define (aux l seen)
    (cond
      [(empty? l) #t]  ; Se a lista estiver vazia, todos os elementos são únicos
      [(member (first l) seen) #f]  ; Se o primeiro elemento já foi visto, há repetição
      [else (aux (rest l) (cons (first l) seen))]))  ; Adiciona o primeiro elemento ao conjunto de elementos já vistos e continua
  (aux L '()))  ; Chama a função auxiliar com a lista original e um conjunto vazio de elementos vistos

;; Testes
(displayln (conjunto? '(a b c d)))  ; Resultado esperado: #t
(displayln (conjunto? '(a b c d b)))  ; Resultado esperado: #f


; Escreva a função que recebe duas listas e testa se a primeira é prefixo da segunda.
; a) Em RACKET: (prefixo? l1 l2)
; Por exemplo:
; > (prefixo? '(a b c) '(a b c d e f g))
; Deve retornar:
; #t
; > (prefixo? '(a b c) '(a b f g))
; Deve retornar:
; #f

(define (prefixo? l1 l2)
  (cond
    [(empty? l1) #t]  ; Se l1 estiver vazia, é um prefixo de qualquer lista
    [(empty? l2) #f]  ; Se l2 estiver vazia e l1 não, l1 não pode ser prefixo
    [(equal? (first l1) (first l2)) (prefixo? (rest l1) (rest l2))]  ; Se o primeiro elemento é igual, continua a comparação
    [else #f]))  ; Se os primeiros elementos são diferentes, l1 não é prefixo

;; Testes
(displayln (prefixo? '(a b c) '(a b c d e f g)))  ; Resultado esperado: #t
(displayln (prefixo? '(a b c) '(a b f g)))  ; Resultado esperado: #f

; Escreva a função que recebe duas listas e testa se a primeira é subsequência da segunda.
; a) Em RACKET: (subsequencia? l1 l2)
; Por exemplo.
; > (subsequencia? '(a b c) '(d z a b c f g))
; Deve retornar:
; #t
; > (subsequencia? '(a b c) '(d z a b f c g))
; Deve retornar:
; #f



(define (subsequencia? l1 l2)
  (cond
    [(empty? l1) #t]  ; Se l1 estiver vazia, ela é uma subsequência de qualquer lista
    [(empty? l2) #f]  ; Se l2 estiver vazia e l1 não, l1 não pode ser subsequência
    [(equal? (first l1) (first l2)) (subsequencia? (rest l1) (rest l2))]  ; Se os primeiros elementos são iguais, continua a verificação
    [else (subsequencia? l1 (rest l2))]))  ; Se os primeiros elementos são diferentes, tenta o próximo elemento de l2

;; Testes
(displayln (subsequencia? '(a b c) '(d z a b c f g)))  ; Resultado esperado: #t
(displayln (subsequencia? '(a b c) '(d z a b f c g)))  ; Resultado esperado: #f

; Sem usar o comando equal?, escreva a função que recebe duas listas genérica e testa se elas são iguais.
; a) Em RACKET: (iguais-lg? lg1 lg2)
; Por exemplo.
; > (iguais-lg? '(a (b c)) '(a (b c)))
; Deve retornar:
; #t
; > (iguais-lg? '(a b c) '(d z a b f c g))
; Deve retornar:
; #f

; (define (iguais-lg? lg1 lg2)
;   (cond
; 	[(and (null? lg1) (null? lg2)) #t]  ; Se ambas as listas estiverem vazias, são iguais
; 	[(or (null? lg1) (null? lg2)) #f]  ; Se apenas uma das listas estiver vazia, são diferentes
; 	[(list? (car lg1)) (and (iguais-lg? (car lg1) (car lg2)) (iguais-lg? (cdr lg1) (cdr lg2)))]  ; Se o primeiro elemento for uma lista, compara recursivamente
; 	[(equal? (car lg1) (car lg2)) (iguais-lg? (cdr lg1) (cdr lg2))]  ; Se os primeiros elementos são iguais, continua a comparação
; 	[else #f])  ; Se os primeiros elementos são diferentes, as listas são diferentes
; )

(define (iguais-lg? lg1 lg2)
  (cond
    [(and (empty? lg1) (empty? lg2)) #t]  ; Ambas as listas estão vazias
    [(or (empty? lg1) (empty? lg2)) #f]   ; Uma lista está vazia e a outra não
    [(and (list? (first lg1)) (list? (first lg2)))  ; Se os primeiros elementos são listas, compara recursivamente
     (and (iguais-lg? (first lg1) (first lg2)) (iguais-lg? (rest lg1) (rest lg2)))]
    [(not (list? (first lg1)))            ; Se os primeiros elementos não são listas, compara diretamente os elementos
     (and (eq? (first lg1) (first lg2)) (iguais-lg? (rest lg1) (rest lg2)))]))

;; Testes
(displayln (iguais-lg? '(a (b c)) '(a (b c))))  ; Resultado esperado: #t
(displayln (iguais-lg? '(a b c) '(d z a b f c g)))  ; Resultado esperado: #f