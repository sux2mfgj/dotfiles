;;
;;(global-set-key "\C-h" delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)

;;
(setq inhibit-startup-message t)

(show-paren-mode 1)

(global-hl-line-mode)

(column-number-mode t)

(line-number-mode t)

(require 'saveplace)
(setq-default save-place t)


; (el-get 'sync '(auto-complete))
; (add-hook auto-complete-mode-hook
;         (lambda ()
;             (define-key ac-completing-map (kbd "C-n") 'ac-next)
;             (define-key ac-completing-map (kbd "C-p") 'ac-previous)))


;; disable display statup message
(setq inhibit-startup-screen t)

;; tool-bar
(tool-bar-mode 0)

;; menu-bar
(menu-bar-mode 0)

;; TAB
(setq default-tab-width 4)

;; use space substitute for tab
(setq-default indent-tabs-mode nil)

;; print correspont ()
(show-paren-mode 1)

;; set color current line
(global-hl-line-mode 1)

;; show color resion
(transient-mark-mode 1)

;; print line and column number
(line-number-mode 1)
(column-number-mode 1)

;; we answer y or n for emacs
(fset 'yes-or-no-p 'y-or-n-p)

;; C-m set newline-and-indent(default is newline)
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; ---- default plugin setting ----
;;print line number 
(require 'linum)
(global-linum-mode 1)



;; Irc settings
;;(setq erc-server "irc.ircnet.ne.jp")
;;(setq erc-port "6660")                  
;;(setq erc-nick "himaaaatti")            

;; symbolic link file to git version controle
(setq vc-follow-symlinks t)

;; back up file settings
(setq make-backup-files nil)

(setq auto-save-default nil)

;; save place of cursol
(require 'saveplace)
(setq-default save-place t)

;; add new line at last line
(setq require-final-newline t)


;; completion
(icomplete-mode 1)

;; spell check
(setq-default flyspell-mode t)
(setq ispless-directory "american")


