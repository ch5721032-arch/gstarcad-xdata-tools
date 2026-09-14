;; xdata-find.lsp - List every object that carries a tag
;; Command: XFIND
(defun c:XFIND ( / ss i en ed tag n )
  (setq ss (ssget "_X") i 0 n 0)
  (if ss
    (repeat (sslength ss)
      (setq en (ssname ss i)
            ed (entget en '("GSC_TAG"))
            tag (cdr (assoc 1000 (cdr (assoc -3 ed)))))
      (if tag
        (progn
          (princ (strcat "\nTag: " tag))
          (setq n (1+ n))
        )
      )
      (setq i (1+ i))
    )
  )
  (princ (strcat "\nTagged objects: " (itoa n)))
  (princ)
)
