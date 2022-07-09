(local os (require :os))
(local math (require :math))
(local string (require :string))
(local rand (require :rand))
(local utils (require :tableutils))
(local procutils (require :procutils))

(fn byte-to-hex [byte]
  (..
    (if (<= byte 15) "0" "")
    (string.format "%x" byte)))

(fn stepper [n]
  (var num n)
  (fn []
      (set num (% (+ num 1) 0xFFFFFF))
      num))

(local int-step (stepper (math.floor (* (rand.rand) 0xFFFFFF))))

(fn to-byte [n] (band n 0XFF))

(fn bytes-to-hex [bytes]
  (if (= (length bytes) 0)
    ""
    (..
      (byte-to-hex (utils.car bytes))
      (bytes-to-hex (utils.cdr bytes)))))


(fn objectid [t machineID pid]
    (let [num (int-step)]
      (bytes-to-hex
        [
         (to-byte (rshift t 24))
         (to-byte (rshift t 16))
         (to-byte (rshift t 8))
         (to-byte t)
         (to-byte (rshift machineID 16))
         (to-byte (rshift machineID 8))
         (to-byte machineID)
         (to-byte (rshift pid 8))
         (to-byte pid)
         (to-byte (rshift num 16))
         (to-byte (rshift num 8))
         (to-byte num)
         ])))

(fn create-generator []
  (local machineID (math.floor (* (rand.rand) 0xFFFFFF)))
  (local pid (% (procutils.get-pid) 0xFFFF))
  (fn [] (objectid (% (os.time) 0xFFFFFFFF) machineID pid)))

{:generate (create-generator)}
