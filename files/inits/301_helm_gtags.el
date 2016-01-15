;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 helm-gtags
 (
  ;; startup gtags-mode
  (add-hook 'c-mode-hook 'helm-gtags-mode)

  ;; key binds
  (add-hook 'helm-gtags-mode-hook
            '(lambda ()
               (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
               (local-set-key (kbd "M-r") 'helm-gtags-find-rtags)
               (local-set-key (kdb "M-s") 'helm-gtags-find-symbol)
               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
               ))
  )
 )
