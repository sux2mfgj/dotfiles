;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 popwin
 ((setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:popup-window-position 'bottom)
  )
 )

