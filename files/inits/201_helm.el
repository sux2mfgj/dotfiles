;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

(package-load-with-check
 helm
 (
  ;; enable helm
  (helm-mode)

  ;; complete tab
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; disable find-file
  ;;(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

  ;; C-h work as backword in mini buffer
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

  ;;
  (defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")
  
  ;; behavior of helm-mini
  (custom-set-variables
   '(helm-mini-default-sources '(helm-source-buffers-list
                                 helm-source-emacs-commands
                                 )))
  
  ;; C-; assign helm-mini
  (define-key global-map (kbd "C-;") 'helm-mini)
  (define-key global-map (kbd "C-x C-b") 'helm-buffers-list)

  ;; config for eshell
  (add-hook 'eshell-mode-hook
            #'(lambda()
                (define-key eshell-mode-map
                  (kbd "M-p")
                  'helm-eshell-history)))
  
  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (define-key eshell-mode-map
                  (kbd "M-n")
                  'helm-esh-pcomplete)))
  )
 )
