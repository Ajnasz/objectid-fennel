(local io (require :io))

(fn getseed []
  (let [f (io.open "/dev/urandom" "r") byteslen 4]
    (let [n (f:read byteslen)]
      (f:close)
      (let [
            bytes [(string.byte n 1 byteslen)]
            ]
        (var output 0)
        (for [i 1 (length bytes)]
          (let [byte (. bytes i)]
            (set output (bor (lshift output byteslen) byte))
            )) output))))

(fn rand []
  (math.randomseed (getseed))
  (math.random))

{:rand rand}
