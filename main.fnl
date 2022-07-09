(local math (require :math))
(local objectid (require :objectid))
(local lapp (require :pl.lapp))

(local opts (lapp "
Generate objectids:
-n,--nosep             optional flag to not append newline
<number> (default 1)   number of objectids to generate
"))

; (fn get-separator [nullchar] (if nullchar "\0" "\n"))
(for [i 1 opts.number]
  (io.write (objectid.generate))
  (when (and (not (. opts :nosep)) (< i opts.number)) (io.write "\n")))
(io.flush)
