;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90)))
  )


(if window-system (progn
    (set-background-color "Gray")
    (set-foreground-color "LightGray")
    (set-cursor-color "Gray")
    (set-frame-parameter nil 'alpha 70)
    ))
