(local io (require :io))
(local strutils (require :strutils))
(local fsutils (require :fsutils))
(local rand (require :rand))

(fn read-pid []
  (strutils.get-first-word (fsutils.get-first-line "/proc/self/stat")))

(fn randrand [] (math.floor (* (rand.rand) 0xFFFF)))

(fn get-pid []
  (if (fsutils.file-exists-p "/proc/self/stat")
    (read-pid)
    (randrand)))

{:get-pid get-pid}
