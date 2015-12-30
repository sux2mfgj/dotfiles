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

  
  
  )
 )

