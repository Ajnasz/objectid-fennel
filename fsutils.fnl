(local rand (require :rand))
(local io (require :io))
(local string (require :string))

(fn file-exists-p [filname]
  (let [f (io.open filname "rb")]
    (if f (do (f:close) true) false)))


(fn get-first-line [filname]
  (let [f (io.open filname "rb")]
    (let [content (f:read)]
      (f:close)
      content)))

{:file-exists-p file-exists-p :get-first-line get-first-line}
