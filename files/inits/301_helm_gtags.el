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
               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
               ))
  

 ;;update gtags
 (defun my-c-mode-update-gtags ()
   (let* ((file (buffer-file-name (current-buffer)))
          (dir (directory-file-name (file-name-directory file))))
     (when (executable-find "global")
       (start-process "gtags-update" nil
                      "global" "-uv"))))

 (add-hook 'after-save-hook
           'my-c-mode-update-gtags)
 )
 )
