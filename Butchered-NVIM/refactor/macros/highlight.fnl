(fn ->str [x]
  (tostring x))

(fn tbl? [x]
  (= :table (type x)))

(lambda highlight! [name attributes colors]
  "Defines a highlight group using the vim API.
  e.g. (highlight! Error [:bold] {:guifg \"#ff0000\"}"
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (tbl? attributes) "expected table for attributes" attributes)
  (assert-compile (tbl? colors) "expected colors for colors" colors)
  (let [name (->str name)
        colors (collect [_ v (ipairs attributes) :into colors] (->str v) true)]
    `(vim.api.nvim_set_hl 0 ,name ,colors)))

(lambda link! [new to old]
  "Defines a highlight group using the vim API.
  e.g. (link! new => old)"
  (assert-compile (sym? new) "expected symbol for new" new)
  (assert-compile (= '=> to) "expected => for to" to)
  (assert-compile (sym? old) "expected symbol for old" old)
  (let [new (->str new)
        old (->str old)]
    `(vim.api.nvim_set_hl 0 ,new {:link ,old})))

{: highlight!
 : link!}
