(local os (require :os))
(local math (require :math))
(local string (require :string))
(local rand (require :rand))
(local utils (require :utils))

(fn byte-to-hex [byte]
  (..
    (if (<= byte 15) "0" "")
    (string.format "%x" byte)
    ))

(local intstep
  (do
    (var nextnum (math.floor (* (rand.rand) 0xFFFFFF)))
    (fn []
      (set nextnum (% (+ nextnum 1) 0xFFFFFF))
      nextnum)))

(fn to-hex-byte [n] (band n 0XFF))
(fn bytes-to-hex [bytes]
  (if (= (length bytes) 0)
    ""
    (..
      (byte-to-hex (utils.car bytes))
      (bytes-to-hex (utils.cdr bytes)))))


(fn objectid [machineID pid]
  (let [t (% (os.time) 0xFFFFFFFF)]
    (let [num (intstep)]
      (bytes-to-hex
        [
         (to-hex-byte (rshift t 24))
         (to-hex-byte (rshift t 16))
         (to-hex-byte (rshift t 8))
         (to-hex-byte t)
         (to-hex-byte (rshift machineID 16))
         (to-hex-byte (rshift machineID 8))
         (to-hex-byte machineID)
         (to-hex-byte (rshift pid 16))
         (to-hex-byte pid)
         (to-hex-byte (rshift num 16))
         (to-hex-byte (rshift num 8))
         (to-hex-byte num)
         ]))))


(local generate (do
  (local machineID (math.floor (* (rand.rand) 0xFFFFFF)))
  (local pid (math.floor (* (rand.rand) 0xFFFFFF)))
  (fn [] (objectid machineID pid))))

{:generate generate}
