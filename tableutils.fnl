(fn car [tbl] (. tbl 1))
(fn cdr [tbl]
  (let [out [(table.unpack tbl)]]
    (table.remove out 1) out))

{:car car :cdr cdr}
