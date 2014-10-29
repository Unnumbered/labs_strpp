(ns lab01-test
  (:use lab01)
  (:require [clojure.test :as test]))

(test/deftest lab01-test
  (test/testing "Testing lab01"
    (test/is (= (words [] 1) []))
    (test/is (= (words ["a"] 0) nil))
    (test/is (= (words ["a"] 1) ["a"]))
    (test/is (= (words ["a"] 2) []))
    (test/is (= (words ["a" "b"] 1) ["a" "b"]))
    (test/is (= (words ["a" "b"] 2) ["ab" "ba"]))
    (test/is (= (words ["a" "b"] 3) ["aba" "bab"]))
    (test/is (= (words ["a" "b" "c"] 2) ["ab" "ac" "ba" "bc" "ca" "cb"]))
  ))

(test/run-tests 'lab01-test)