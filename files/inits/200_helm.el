;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

(package-load-with-check
 helm-config
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

  ;; C-; assign helm-mini
  (define-key global-map (kbd "C-;") 'helm-mini)

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

  ;; config for gtags
  (add-hook 'helm-gtags-mode-hook
            '(lambda ()
               ;;jump to definition
               (local-set-key (kbd "M-t") 'helm-gtags-find-tag)

               ;;jump to reference
               (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)

               ;;jump to symbol
               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)

               ;;list of tags
               (local-set-key (kbd "M-l") 'helm-gtags-select)

               ;;back to the feature
               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

  (add-hook 'c-mode-common-hook 'helm-gtags-mode)
  (add-hook 'asm-mode-hook 'helm-gtags-mode)
  
  )
 )

