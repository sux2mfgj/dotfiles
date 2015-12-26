;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

;; macro for package
(defmacro package-load-with-check (package-name body)
  `(cond
    ((locate-library ,(symbol-name package-name))
     (require ',package-name)
     ,@body
     (message (concat "[package] " ,(symbol-name package-name) " was loaded"))
     )
    ((unless (package-installed-p ',package-name))
     (package-install ',package-name)
     (message (concat "install " ,(symbol-name package-name)))
     )
    (t
     (message (concat ,(symbol-name package-name) " error occured"))
     )
    )
  )


