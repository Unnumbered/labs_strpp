(ns lab03 (:gen-class))

(defn integral [func dx]
  (def integ (reductions + (map (fn [m] (/ (* (+ (func (* dx (- m 1))) (func (* dx m))) dx) 2.0)) (iterate inc 1))))
  (fn [x]
    (+ (nth integ (- (quot x dx) 1) ) (/ (* (+ (func (* dx (quot x dx))) (func x)) (- x (* dx (quot x dx)))) 2.0))
    ))
