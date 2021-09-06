(local io (require :io))

(fn getseed [byteslen]
  (let [f (io.open "/dev/urandom" "r")]
    (let [n (f:read byteslen)]
      (f:close)
      (let [bytes [(string.byte n 1 byteslen)]]
        (var output 0)
        (for [i 1 (length bytes)]
          (let [byte (. bytes i)]
            (set output (bor (lshift output byteslen) byte))
          )
        )
        output))))

(fn rand []
  (math.randomseed (getseed 4))
  (math.random))

{:rand rand}
