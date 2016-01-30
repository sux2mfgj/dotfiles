;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 clang-format

 (
  (with-eval-after-load 'c-mode-hook

    ;;clang-format
    (add-hook 'before-save-hook 'clang-format-before-save)
    )
  )
 )
