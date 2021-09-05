(local math (require :math))
(local objectid (require :objectid))
(local rand (require :rand))

(let [count (if (= (length arg) 1) (. arg 1) 1)]
  (for [i 1 count] (print (objectid.generate))))
