(local string (require :string))

(fn get-first-word [str]
  (string.sub str 1 (- (string.find str " ") 1)))

{:get-first-word get-first-word}
