(local string (require :string))
(local os (require :os))
(fn date-from-objectid [oid]
  (tonumber (string.sub oid 0 8) 16))

(print (os.date "%Y-%m-%d %H:%I:%S" (date-from-objectid (. arg 1))))
