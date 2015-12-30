;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

;; macro for package
(defmacro package-load-with-check (package-name body)
  `(cond
    ((locate-library ,(symbol-name package-name))
     (require ',package-name)
     ,@body
     (message (concat "[ok] " ,(symbol-name package-name) " was loaded"))
     )
    ((package-installed-p ',package-name)
     (package-install ',package-name)
     (message (concat "[ok] install " ,(symbol-name package-name)))
     )
    (t
     (message (concat "[error] " ,(symbol-name package-name)))
     )
    )
  )


