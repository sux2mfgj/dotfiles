;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 go-mode
 (

  (package-load-with-check
   go-autocomplete
   ()
   )
  
  (with-eval-after-load 'go-mode
    ;; gofmt
    (add-hook 'before-save-hook 'gofmt-before-save)
    )
  )
 )
