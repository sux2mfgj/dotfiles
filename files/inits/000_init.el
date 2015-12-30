;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

;; for backspace (C-h)
(keyboard-translate ?\C-h ?\C-?)

;; don't show start up message
(setq inhibit-startup-message t)

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

;; use space substitute for tab
(setq-default indent-tabs-mode nil)

;; Color(background and foreground)
(if window-system (progn
                    (set-background-color "Black")
                    (set-foreground-color "LightGray")
                    (set-cursor-color "Gray")
                    (set-frame-parameter nil 'alpha 100)
                    ));

;; tool-bar
(tool-bar-mode 0)

;; menu-bar
(menu-bar-mode 0)

;;
(global-hl-line-mode)

;; symbolic link file to git version controle
(setq vc-follow-symlinks t)

;; back up file settings
(setq make-backup-files nil)

;; add new line at last line
(setq require-final-newline t)

;; font size 
(set-face-attribute 'default nil :height 150)

;; change meta key
;(100 . 'hira)
;(add-to-list 'system-key-alist '(100 . hiragana-katakana))
;(setq x-super-keysym 'hiragana-katakana) 
;system-key-alist

;;TODO
;; add another configuration
