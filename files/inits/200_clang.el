;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-


(defun clang-format-before-save ()
    "hook before save"
    (interactive)
    (when (eq major-mode 'c-mode) (clang-format-buffer))
  )

(package-load-with-check
 clang-format
 (

  ;; clang-format save hook
  (add-hook 'before-save-hook 'clang-format-before-save)

  ;; style
;;  (setq clang-format-style "{BasedOnStyle: Google, IndentWidth: 4}")
  (setq clang-format-style "file")
  
  ;;(with-eval-after-load 'c-mode-hook
    
    ;;clang-format
    ;;(add-hook 'before-save-hook 'clang-format-before-save)
    ;;)

  ;; auto change mode
  (add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
  
  )
 )
