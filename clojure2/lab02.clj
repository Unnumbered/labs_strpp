(ns lab02 (:gen-class))

(defn integral [func dx]
  (def integ 
    (memoize 
      (fn [n] 
        (if (> n 0) (+ (integ (- n 1)) (/ (* (+ (func (* dx (- n 1))) (func (* dx n))) dx) 2.0)) 0))))
  (fn [x]
    (+ (integ (quot x dx)) (/ (* (+ (func (* dx (quot x dx))) (func x)) (- x (* dx (quot x dx)))) 2.0))
    ))
