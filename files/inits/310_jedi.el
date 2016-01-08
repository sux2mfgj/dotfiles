;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 jedi
 (
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  )
 )
