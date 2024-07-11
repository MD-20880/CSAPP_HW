1.2
(/ (+ 5 4 (- 2 ( - 3 ( + 6 (/ 4 5)))) (* 3 (- 6 2 ) ( - 2 7))))


1.3
(define (incre a b c) (and (> a b) (> b c)))
(define (f a b c) 
        (cond ((decre a b c) (+ a b))
                ((decre a c b) (+ a c)) 
                ((decre b a c) (+ b a))
                ((decre b c a) (+ b c)) 
                ((decre c a b) (+ c a)) 
                ((decre c b a) (+ c b))))