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

STEP1: Given Level l and index x calculate value 
(define (pascal-iter l i) (cond 
                                ((and (= l 1) (= i 1)) 1)
                                ((and (< i (+ l 1)) (> i 0)) (+ (pascal-iter (- l 1) i) 
                                                          (pascal-iter (- l 1) (- i 1))
                                                          ))
                                (else 0)
                                ))


1.13



1.18
(define (double num) (* num 2))
(define (halve num) (/ num 2))
(define (times a b) (cond 
                        ((or (= a 0) ( = b 0)) 0)
                        ((even? b) (double (times a (halve b))))
                        (else (+ a (times a (- b 1))))
                        ))
(define (even? num) (= (remainder num 2) 0))


1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (p-next p q) (+ (* p p) (* q q)))
(define (q-next p q) (+ (* 2 p q) (* q q)))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (p-next p q)  ; compute p'
                   (q-next p q)  ; compute q'
                   (/ count 2)))
        (else
         (fib-iter (+ (* b q) (* a q) (* a p))
                   (+ (* b p) (* a q))
                   p
                   q
                   (- count 1)))))


1.22
(define (fermat-test n) 
        (define (try-it a)
                (= (expmond a n n) a))
        (try-it (+1 (random (- n 1)))))

(define (expmond base exp m)
        (cond ((= exp 0) 1)
                ((even? exp) (remainder (square (expmond base (/ exp 2) m)) m))
                (else (* (remainder base m) (remainder (expmond base (- exp 1) m) m)))))

(define (fast-prime? n times)
        (if (= times 0) 1)
                (and (fermat-test n ) (fast-prime? n (- times 1))))

(define (timed-prime-test n)
        (newline)
        (display n)
        (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
        (if (prime? n)
                (report-time (- (runtime) start-time))))

(define (report-prime elapsed-time)
        (display " * * * ")
        (display elapsed-time))

(define (prime? n)
        (fast-prime? n 10))

(define (search-for-prime floor nums) 
        (timed-prime-test (search-prime-incre floor))
        (search-for-prime (+ (search-prime-incre floor))))

(define (search-prime-incre n)
        (case ((prime? n) n)
                ((even? n) (search-prime-incre (+ n 1)))
                (else (search-prime-incre (+ n 2)))))   

#如果不能运行，加上
(define (runtime) 20)
(define (sqare n) (* n n))

#运行
(search-for-prime 1000 3)

#runtime 函数不可用，相关练习先搁置


(define (expmond base exp m)
        (define (square-when-pass-check base exp m)
                (cond ((= (remainder (square (expmond base (/ exp 2) m)) m) 1) 0)
                        (else (remainder ( square (expmond base (/ exp 2) m)) m))))
        (define (square-when-not-one n) (if (= n 1)
                                                0
                                                (square n)))
        (cond ((= exp 0) 1)
                ((even? exp) (remainder ( square-when-not-one (expmond base (/ exp 2) m)) m))
                (else (remainder (* base (expmond base (- exp 1) m)) m))))




#1.29
(define (even? n) (= (remainder n 2) 0))
(define (next-leading-factor i n) (if (and (= i 1) (= i n)) 
                                        1
                                        (case ((even? i) 2)
                                                (else 4))))
(define (sum term a next b) (
        (if (> a b) 
                0
                (+      (term a) 
                        (sum term (next a) next b)))
))

(define (simpson-rule f a b n) (
        
))


#1.32
#a
(define (accumulate combiner null-value term a next b)
        (if (> a b)
                null-value
                (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b) 
        (accumulate + 0 term a next b))

(define (product term a next b)
        (accumulate * 1 term a next b))

#b
(define (accumulate-iter combiner null-value term a next b)
        (define (accumulate-iter-inner a result) 
                (if (> a b)
                        result
                        (accumulate-iter-inner (next a) (combiner result (term a)))))
        (accumulate-iter-inner a null-value))

(define (sum term a next b) 
        (accumulate-iter + 0 term a next b))

(define (product term a next b)
        (accumulate-iter * 1 term a next b))


#1.33
(define (filtered-accumulate filter combiner null-value term a next b)
        (define (term-or-null a) 
                (if (= (filter a) 1)
                        (term a)
                        null-value))
        (define (accumulate-if-match a)
                (if (> a b)
                        null-value
                        (combiner (term-or-null a) (accumulate-if-match (next a)))))
        (accumulate-if-match a))

(define (filter a)
        (cond ((= a 1) 1)
                ((= a 50) 1)
                (else 0)))


#1.35
(define (abs a) 
        ((if (< a 0)
                -
                +) a))

(define (fixed-point f guess)
        (let ((tolerence 0.001))
        (if (< (abs (- (f guess) guess)) tolerence)
                guess
                (fixed-point f (f guess)))))

(define (calculate-phi guess)
        (define (golden-ratial a)
                (+ 1 ( / 1 a)))
        (fixed-point golden-ratial guess))

#1.36

(define (fixed-point f guess)
        (let ((tolerence 0.001))
        (define (fixed-point-display-iter guess) 
                (newline)
                (display guess)
                (if (< (abs (- guess (f guess))) tolerence)
                        guess
                        (fixed-point-display-iter (f guess))))
        (fixed-point-display-iter guess)
        )
        )

(define (calculate-log guess) 
        (fixed-point (lambda (y) (/ (log 1000.0) (log y))) guess))

(define (calculate-log-average guess)
        (define (f y) (+ (/ ( log 1000.0) (* 2 (log y))) (/ y 2)))
        (fixed-point f guess))

#1.37
(define (cont-frac n d k)
        (let ((maxiter k))
        (define (cont-frac-inner k)
                (newline)
                (if (> k maxiter)
                        0
                        (/ (n k) (+ (d k) (cont-frac-inner (+ k 1))))))
        (cont-frac-inner 1)))

(define (cont-frac n d k)
        (define (cont-frac-inner k result)
                (if (< k 1)
                        result
                        (cont-frac-inner (- k 1) (/ (n k) (+ (d k) result)))))
        (cont-frac-inner k 0.0))


# 你需要取多大的k才能保证得到的近似值具有十进制的4位精度？

(lambda (k) (if (= (remainder k 3) 0)
                (* (/ k 3) 2)
                1))
(cont-frac (lambda (y) 1.0) 
        (lambda (k) (if (= (remainder (+ k 1) 3) 0) (* (/ (+ k 1) 3) 2) 1))
                        10.0)


#1.39
(define (tan-cf x k)
        (cont-frac-reverse (lambda (k) (if (= k 1) x (* x x))) (lambda (k) (- (* k 2) 1)) k))

(define (cont-frac-reverse n d k)
        (define (cont-frac-inner k result)
                (if (< k 1)
                        result
                        (cont-frac-inner (- k 1) (/ (n k) (- (d k) result)))))
        (cont-frac-inner k 0.0))


#1.40
(define (fixed-point f guess)
        (let ((tolerence 0.00001))
        (define (fixed-point-display-iter guess) 
                (newline)
                (display guess)
                (if (< (abs (- guess (f guess))) tolerence)
                        guess
                        (fixed-point-display-iter (f guess))))
        (fixed-point-display-iter guess)
        )
        )

(define (newton-transform g)
        (lambda (x) 
                (- x (/ (g x) ((derive g) x)))))

(define (newton-method g guess)
        (fixed-point (newton-transform g) guess))

(define (derive g)
        (let ((dx 0.00001))
                (lambda (x)
                        (/ (- (g (+ x dx)) (g x))
                                dx))))

(define (cubic a b c)
        (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))
                

#1.41
(define (double g)
        (lambda (x) (g (g x))))

(define (inc x)
        (+ x 1))

(((double (double double)) inc) 5)

#1.42
(define (compose f g)
        (lambda (x) (f (g x))))

((compose (lambda (x) (* x x)) (lambda (x) (+ x 1))) 6)

#1.43
(define (repeated f times)
        (lambda (x) 
                (if (= times 0)
                        x
                        (f ((repeated f (- times 1)) x)))))

#1.44
(define (smooth g)
        (let ((dx 0.00001))
                (lambda (x) (/ (g (- x dx) (g x) (g (+ x dx))) 3))))

(define (nth-smooth g n)
        (repeated g n))

#1.45
(define (average x y)
        (/ (+ x y) 2))

(define (average-damp g)
        (lambda (x) (average x (g x))))

(define (sqrt-n-with-m-damp x n m guess)
        (
        fixed-point (repeated (average-damp (lambda (y) (/ x ((repeated (lambda (z) (* y z)) (- n 2)) y)))) m) guess
        ))

#1.46
(define (iterative-improve good-enough? improve)
        (define (iterative-improve-inner guess)
                (if (good-enough? guess)
                        guess
                        (iterative-improve-inner (improve guess)))))

#找个时间做掉把:p

