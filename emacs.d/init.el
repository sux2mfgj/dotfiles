
;;
(global-set-key "\C-h" delete-backward-char)

;;
(setq inhibit-startup-message t)


(menu-bar-mode -1)

(tool-bar-mode -1)

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

