;Meital Birka
;311124283
;group 04
;birkame



;(define x (+ 2 5))

(define (ends-with suffix str)(ends_h suffix str 0 0))
  (define (ends_h suffix str counter_suffix counter_str)
  (let*(
        (len-suffix(string-length suffix))
        (len-str(string-length str))
        )
    (cond ((= counter_suffix len-suffix)  #t)
          ((= counter_str len-str) #f)
          (else  (let*(
                       (a (list-ref (string->list str)counter_str ))
                       (b (list-ref (string->list suffix) counter_suffix))
                       )
  
                   (cond ((char=? a b) 
                          (ends_h suffix str (+ counter_suffix 1) (+ counter_str 1)))
                         (else (ends_h suffix str  counter_suffix  (+ counter_str 1)))
                         )))
          )
    )
)

(define (mul-of-pairs suffix ls)
    (define (mul_h suffix ls answer)
      (if (null? ls)
          answer
          (let*(
                (current_node (car ls))
                (rest_list(cdr ls))
                (str_myNode(car current_node))
                (num_myNode(cdr current_node))
                (func(ends-with suffix str_myNode))
                )
                (cond ((and func #t)
                       (mul_h  suffix rest_list (* answer num_myNode)))
                      (else (mul_h  suffix rest_list  answer ))
      
                      )

                ))
      )
  (mul_h  suffix ls 1)
)
    
(define (merge ls1 ls2)
  (define (merge_h ls1 ls2 numList)
    (cond ((null? ls1) ls2)
          ((null? ls2) ls1)
          ((= numList 1) (cons (car ls1) (merge_h (cdr ls1) ls2 2)))
          (else (cons (car ls2) (merge_h ls1 (cdr ls2) 1)))
          )
          )
  (merge_h ls1 ls2 1)
  )

  
(define (rotate ls n)
  (cond
    ((or (= n 0) (null? ls)) 
     ls)
    (else
     (let*(
           (opList(reverse ls))
           (cdrRest(reverse (cdr opList)))
           )
       (rotate (append (list (car opList)) (reverse (cdr opList)) ) (- n 1))
       )
     )
    )
  )


(define (comp x y)
  (cond((< x y) -1)
       ((> x y) 1)
       (else 0))
  )

(define (quicksort comp)
  (lambda (lst)
    (cond ((null? lst) '())
          ((= (length lst) 1) lst)
          (else (let*( (pivot(car lst))
                 
                 
                 (little (filter(lambda (x)  (<= (comp x pivot) -1)) lst))
                 (same   (filter(lambda (x)  (=  (comp x pivot) 0)) lst))
                 (big    (filter(lambda (x)  (>= (comp x pivot) 1)) lst))
                 )
             
              (append (append ((quicksort comp)little) same) ( (quicksort comp)big) ) 
            
             )
        )
    )

  )
  )

(define (hd s)
  (car s)
  )

(define (tail s)
  ((cdr s))      
  )

(define (seq n)
 (cons n (lambda () (seq (+ n 1))))
  )

(define (seq-gen n g)
  (cons n (lambda () (seq-gen (g n) g)))
  )
(define (add-lists ls1 ls2)
(append ls1 ls2)
  )
(define (cyclic-seq ls)
  (let*(
       ; (first(list-ref ls 0))
        ;(second(list-ref ls 1))
       ; (rest( cdr ls))
       ; (h(add-lists (add-lists rest (list first)) (list second)))
       ; (all(add-lists (list first) h))
        (f(car ls))
        ;(last(cdr all))
        )
    ;(append (append ls (list first)) (list second))
  ;(cons f (lambda ()  (cyclic-seq(rotate last 0))))
    (cons f (lambda ()  (cyclic-seq(rotate ls (- (length ls) 1)))))
    )
  )
(define (find y x)
  
(cond ((null? y) '())
      ((null? x) y)
      (else (let*(
                  ;(current(car y))
                  (key(car y))
                  (val(cdr y))
                  (rest(cdr y))
                  )
              (cond
                    ((string=? x key)val)
                    (else (find rest x)))
              )))

  )
;(define (add  k v)
;   (cons k v) 
;)
(define (checkExist lst key)
  (let*((a(length lst))
        (b 0)
        )
  (cond  ((= a b) #f)
         (else 
        
 (let*(
            
            (current_pair (car lst))
            (current_key (car current_pair))
            (current_val (cdr current_pair))
            (rest_list (cdr lst))
            )
        (cond ((null? lst) #f)
              ((string=? key current_key)#t)
              (else (checkExist rest_list key))
       )
      )
 ))
)
  )
(define (newLBeforeKey key lst newlst)
(let*(
            (current_pair (car lst))
            (current_key (car current_pair))
            (current_val (cdr current_pair))
            (rest_list (cdr lst))
            )
        (cond ((null? lst) #f)
              ((string=? key current_key) newlst)
              (else (newLBeforeKey key rest_list (cons current_pair newlst) ))
       )
      )
  )
(define (newLAfterKey key lst )
(let*(
            (current_pair (car lst))
            (current_key (car current_pair))
            (current_val (cdr current_pair))
            (rest_list (cdr lst))
            )
        (cond ((null? lst) #f)
              ((string=? key current_key) rest_list)
              (else (newLAfterKey key rest_list ))
       )
      )
  )

(define (make-dictionary )
  (define (dictionary ls)
    (define (addValue lst key val found res)
      (cond ((and #t (checkExist lst key))

             ;(cons (cons (newLBeforeKey key ls '()) (newLAfterKey key ls)) (cons key val))
             (append (append (list (cons key val)) (newLBeforeKey key ls '())) (newLAfterKey key ls))


             )
             (else(cons (cons key val) lst)
              )
      ))
    (define (findA lst key)
      (let*(
            (current_pair (car lst))
            (current_key (car current_pair))
            (current_val (cdr current_pair))
            (rest_list (cdr lst))
            )
        (cond ((null? lst) '())
              ((string=? key current_key)current_val)
              (else (findA rest_list key)) 
       )
      )
      )
    (define (dic_funcs e)
      (cond ((null? e ) ls)
            ((pair? e ) (dictionary(addValue ls (car e) (cdr e) #f '())))
            (else (findA ls e))
            )
      )
    dic_funcs 
    )
  (dictionary '())
  )
  







(define (map2 f)
  (define (map2-internal ls)
	(if (null? ls)
	 ls 
	(cons (f (car ls)) 
			(map2-internal (cdr ls)))))
   map2-internal)


(define (filter p ls)
  (if (null? ls)
      ls
      (let
          (               
           (hd (car ls))
           (rest (cdr ls))
           )                
        (if ( p hd)
            (cons hd (filter p rest))
            (filter p rest)
            )
        ))
)
                    



(define (reduce binFunc u)
  (define (reduce-helper ls)
    (if (null? ls)
        u
        (binFunc (car ls) (reduce-helper (cdr ls)))))
  reduce-helper)
(load "test.scm")