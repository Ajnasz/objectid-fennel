(local io (require :io))
(local os (require :os))

(var dumbseednum 42)
(fn dumbseed []
  (set dumbseednum (+ dumbseednum 1))
  (+ (os.time) dumbseednum))

(fn getseed []
  (let [f (io.open "/dev/urandom" "r")]
    (if f
      (let [
            byteslen 4
            n (f:read byteslen)
            ]
        (f:close)
        (let [bytes [(string.byte n 1 byteslen)]]
          (var output 0)
          (for [i 1 (length bytes)]
            (let [byte (. bytes i)]
              (set output (bor (lshift output byteslen) byte))
              )
            )
          output))
      (dumbseed)
      )))

(fn rand []
  (math.randomseed (getseed 4))
  (math.random))

{:rand rand}
