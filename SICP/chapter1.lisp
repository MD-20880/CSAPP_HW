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

1.7 
(define (improve y x) (/ (+ y (/ x y)) 2))
(define (good-enough dy y) (< (/ dy y) 0.01))
(define (abs x) ((if (> 0 x) - +) x ))
(define (sqrt-iter guess delta x) (if (good-enough delta x) guess (sqrt-iter (improve guess x) (abs (- (improve guess x) guess)) x)))
(sqrt-iter 1 1 2)

1.8
(define (improve y x) (/ (+ (/ x (* y y) (* 2 y))) 3))
(define (good-enough dy y) (< (/ dy y) 0.5))
(define (abs x) ((if (> 0 x) - +) x ))
(define (cube-sqrt-iter guess delta x) (if (good-enough delta x) guess (cube-sqrt-iter (improve guess x) (abs (- (improve guess x) guess)) x)))
(cube-sqrt-iter 2.5 1 27)

1.11
(define (f-iter n3 n2 n1 nc n) (cond
                                ((< n 3) n)
                                ((< nc n) (f-iter n2 n1 (f-next n3 n2 n1) (+ nc 1) n))
                                (else n1)
                                ))
(define (f n) (f-iter 0 1 2 2 n))
(define (f-next n3 n2 n1) (+ (* n3 3) (* n2 2) n1))


1.12

1.13
