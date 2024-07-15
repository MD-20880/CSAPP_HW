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

<<<<<<< HEAD

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


P52
