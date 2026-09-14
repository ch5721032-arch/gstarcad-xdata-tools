;; xdata-tag.lsp - Attach a small tag to an object as XDATA
;; Command: XTAG
;; Usage: APPLOAD -> XTAG -> pick an object -> type a tag (e.g. ISSUE-2)
(defun c:XTAG ( / en ed tag )
  (setq en (car (entsel "\nPick an object to tag: ")))
  (if en
    (progn
      (setq tag (getstring T "\nTag text: "))
      (if (/= tag "")
        (progn
          (regapp "GSC_TAG")
          (setq ed (entget en)
                ed (append ed (list (list -3 (list "GSC_TAG" (cons 1000 tag))))))
          (entmod ed)
          (princ (strcat "\nTag stored: " tag))
        )
      )
    )
  )
  (princ)
)
