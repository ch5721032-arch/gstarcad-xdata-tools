# GstarCAD XDATA Tools

Attach a small tag to any object as XDATA, read it back and find every tagged object.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Sometimes an object needs to carry a note that should never print: which issue changed it, who owns it, what it is for. These tools attach a small tag to any object as extendable data, read the tag back with one pick, and list every tagged object in the drawing.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/xdata-tag.lsp` | ;; xdata-tag.lsp - Attach a small tag to an object as XDATA
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
 |
| `scripts/xdata-list.lsp` | ;; xdata-list.lsp - Read the GSC_TAG tag from a picked object
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
 |
| `scripts/xdata-find.lsp` | ;; xdata-find.lsp - List every object that carries a tag
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
