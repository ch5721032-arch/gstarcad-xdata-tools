;; xdata-list.lsp - Read the GSC_TAG tag from a picked object
;; Command: XLIST
(defun c:XLIST ( / en ed tag )
  (setq en (car (entsel "\nPick a tagged object: ")))
  (if en
    (progn
      (setq ed (entget en '("GSC_TAG"))
            tag (cdr (assoc 1000 (cdr (assoc -3 ed)))))
      (if tag
        (princ (strcat "\nTag: " tag))
        (princ "\nNo GSC_TAG tag on this object.")
      )
    )
  )
  (princ)
)
