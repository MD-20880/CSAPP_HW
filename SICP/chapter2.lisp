#2.1
(define (make-rat n d)
        (let ((g (gcd n d))
                (sign (lambda (x) (if (< x 0) 
                                        -1
                                        1))))
                (cond ((= (sign n) (sign d)) (cons (abs n) (abs d)))
                        (else (cons (- 0 (abs n)) (abs d))))
                )) 

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


(define (numer x)
        (car x))

(define (denom x)
        (cdr x))

(define (print-rat x)
        (newline)
        (display (numer x))
        (display "/")
        (display (denom x))
        (newline))

(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))
(define one-forth (make-rat 1 4))

(print-rat (add-rat one-half one-forth))

#2.2
(define (make-point x y) (cons x y))
(define (point-x p) (car p))
(define (point-y p) (cdr p))

(define (make-segment p-start p-end)
        (cons p-start p-end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
        (let ((avg (lambda (axis) (/ (+ (axis (start-segment s)) 
                                (axis (end-segment s)))
                            2)))
            )
            (make-point (avg point-x) (avg point-y))))

(define (print-point p)
        (newline)
        (display "(")
        (display (point-x p))
        (display ",")
        (display (point-y p))
        (display ")")
        (newline)
)


#2.3
(define (make-rect1 x y) 
        (cons x y))
(define (rect-width) (car p))
(define (rect-height) (cdr p))

(define (make-rect2 p-bl p-ur) (cons p-bl p-ur))
(define (rect-width r) (- (point-x (cdr r)) (point-x (car r))))
(define (rect-height r) (- (point-y (cdr r)) (point-y (car r))))

(define (rect-circumference r) (* 2 (+ (rect-width r) (rect-height r))))
(define (rect-area r) (* (rect-width r) (rect-height r)))

#2.4
(define (cons x y) (lambda (m) (m x y)))
(define (car z) (lambda (p q) p))
(define (cdr z) (lambda (p q) q))

#2.5
(define (pow x y)
        (let ((even? (lambda (z) (if (= (remainder z 2) 0)
                                            1
                                            0))))
        (cond   ((= y 0) 1)
                ((= (even? y) 1) (* (pow x (/ y 2)) (pow x (/ y 2))))
                (else (* x (pow x (- y 1))))
                )))

(define (cons x y) 
        (let ((pow2 (lambda (a) (pow 2 a)))
                (pow3 (lambda (b) (pow 3 b))))
                (* (pow2 x) (pow3 y))))

(define (extract a b)
        (define (extract-inner c r) (if (= (remainder c b) 0)
                                                    (extract-inner (/ c b) (+ r 1))
                                                        r))
            (extract-inner a 0))

(define (car x) (extract x 2))
(define (cdr x) (extract x 3))

#2.6
;; 定义零
(define zero
  (lambda (f)
    (lambda (x)
      x)))

;; 定义加一
(define (add-one n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))


(define (add a b)
        (lambda (f) (lambda (x) ((b f) (a f) x))))

#2.7
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))
(define (upper-bound z) (cdr z))
(define (lower-bound z) (car z))

;2.8
(define (sub-interval a b)
        (make-interval (- (lower-bound a) (lower-bound b))
                        (- (upper-bound a) (upper-bound a))))


(define (print-interval a)
        (newline)
        (display "(")
        (display (lower-bound a))
        (display ",")
        (display (upper-bound a))
        (display ")"))