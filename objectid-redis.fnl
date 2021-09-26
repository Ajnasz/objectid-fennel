;;;; objectid-redis lua script to generate mongodb objectid in redis

(do
  (local t (redis.call "time"))
  (math.randomseed
  (+ (* (tonumber (. t 1)) 1000000) (tonumber (. t 2)))))

(fn car [tbl] (. tbl 1))
(fn cdr [tbl]
  (let [out [(unpack tbl)]]
    (table.remove out 1)
    out
    ))

(fn byte-to-hex [byte]
  (..
    (if (<= byte 15) "0" "")
    (string.format "%x" byte)))

(fn stepper [n]
  (var num n)
  #(do (set num (% (+ num 1) 0xFFFFFF))
     num))

(local int-step (stepper (math.floor (* (math.random) 0xFFFFFF))))

(fn to-byte [n] (bit.band n 0XFF))

(fn bytes-to-hex [bytes]
  (if (= (length bytes) 0)
    ""
    (..
      (byte-to-hex (car bytes))
      (bytes-to-hex (cdr bytes)))))


(fn objectid [t machineID pid]
  (let [num (int-step)]
    (bytes-to-hex
      [
       (to-byte (bit.rshift t 24))
       (to-byte (bit.rshift t 16))
       (to-byte (bit.rshift t 8))
       (to-byte t)
       (to-byte (bit.rshift machineID 16))
       (to-byte (bit.rshift machineID 8))
       (to-byte machineID)
       (to-byte (bit.rshift pid 8))
       (to-byte pid)
       (to-byte (bit.rshift num 16))
       (to-byte (bit.rshift num 8))
       (to-byte num)
       ])))

(fn create-generator []
  (local machineID (math.floor (* (math.random) 0xFFFFFF)))
  (local pid (math.floor (* (math.random) 0xFFFF)))
  (print machineID pid)
  #(let [t (redis.call "time")]
     (objectid
       (% (. t 1) 0xFFFFFFFF)
       machineID pid)))
(let [objectid (create-generator)
      output []]
    (for [i 1 (tonumber (. KEYS 1))]
      (table.insert output (objectid)))
    output)
