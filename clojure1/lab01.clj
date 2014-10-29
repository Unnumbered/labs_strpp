(ns lab01 (:gen-class))
(defn words [alphabet len]
  (if (> len 0)
  (nth
    (iterate
      (fn [a]
        (remove nil?
        (flatten
        (map
          (fn [e]
            (map
              (fn [e2]
                (if (not= (first e2) (last e))
                  (str e e2)))
              alphabet))
          a))))
      alphabet)
    (- len 1))))