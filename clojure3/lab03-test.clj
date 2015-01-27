(ns lab03-test
  (:use lab03)
  (:require [clojure.test :as test]))

(defn ff1 [x] 1)
(defn ff2 [x] x)
(defn ff3 [x] (+ 2 (* 2 x)) )

(test/deftest lab03-test
  (test/testing "Testing lab03"
    (test/is (= ((integral ff1 1) 2.5) 2.5))
    (test/is (= ((integral ff2 2) 5) 12.5))
    (test/is (= ((integral ff3 2) 3) 15.0))
    ))

(test/run-tests 'lab03-test)