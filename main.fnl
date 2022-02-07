(local math (require :math))
(local objectid (require :objectid))
(local rand (require :rand))

(let [count (if (= (length arg) 1) (tonumber (. arg 1)) 1)]
  (for [i 1 count]
    (io.write (objectid.generate))
    (when (< i count) (io.write "\n"))
    ))
(io.flush)
