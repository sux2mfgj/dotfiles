;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

;auto-compete
(package-load-with-check
 auto-complete-config
 ((ac-config-default)
  (add-to-list 'ac-modes 'text-mode)
  (add-to-list 'ac-modes 'fundamental-mode)
  (add-to-list 'ac-modes 'org-mode)
  (ac-set-trigger-key "TAB")
  (setq ac-use-menu-map t)
  (setq ac-use-fuzzy t)

  ;; config for eshell
  (require 'pcomplete)
  
  (add-to-list 'ac-modes 'eshell-mode)
  
   (ac-define-source pcomplete
     '((candidates . pcomplete-completions)))


ac-complete-pcomplete
   (defun my-ac-eshell-mode ()            
    (setq ac-sources
          '(ac-source-pcomplete
            ac-source-filename
            ac-source-files-in-current-dir
            ac-source-words-in-buffer
            ac-source-dictionary)))

   (add-hook 'eshell-mode-hook
             (lambda ()
               (my-ac-eshell-mode)
               (define-key eshell-mode-map (kbd "C-i") 'auto-complete)
               (define-key eshell-mode-map [(tab)] 'auto-complete)))
  )
 )


