(local math (require :math))
(local objectid (require :objectid))
(local rand (require :rand))


(for [i 1 10]
  (print (objectid.generate)))
