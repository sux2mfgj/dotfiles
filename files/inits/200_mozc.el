;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-


(package-load-with-check
 mozc
 (
  (prefer-coding-system 'utf-8)

  (setq default-input-method "japanese-mozc")

  ;; font
  ;;  (set-face-attribute 'default nil
  ;;                     :family "Ricty Discord"
  ;;                    :height 120)

  (set-face-attribute 'default nil
                      :family "Inconsolata"
                      :height 120)  
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (cons "Ricty Discord" "iso10646-1"))
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0212
                    (cons "Ricty Discord" "iso10646-1"))
  (set-fontset-font (frame-parameter nil 'font)
                    'katakana-jisx0201
                    (cons "Ricty Discord" "iso10646-1"))
  ))

