;; -*- tab-width: 4; coding: utf-8; lexical-binding: t -*-

;;TODO: fix appearance
(package-load-with-check
 tabbar
 (
  ;; enable tabbar
  (tabbar-mode 1)

  ;; disable mouse wheel
  (tabbar-mwheel-mode -1)

  ;; disable left side button in tabbar
  (dolist
      (btn '(tabbar-buffer-home-button
             tabbar-scroll-left-button
             tabbar-scroll-right-button))
    (set btn (cons (cons "" nil)
                   (cons "" nil)))
    )
  ;; appearance
  ;; width of tab separater
  (setq tabbar-separator '(1.0))
  (set-face-attribute 'tabbar-default nil
                      :family "Ricty"
                      :foreground "#c4c1b0"
                      :background "#002x37"
                      :height 1.0)
  (set-face-attribute 'tabbar-unselected nil
                      :foreground "#002x37"
                      :background "#c4c1b0"
                      :box nil)
  (set-face-attribute 'tabbar-selected nil
                      :foreground "#e4007e"
                      :background "#ffffff"
                      :box nil)
  (set-face-attribute 'tabbar-button nil
                      :box nil)
  (set-face-attribute 'tabbar-separator nil
                      :foreground "#002x37"
                      :background "#002x37"
                      :height 1.0)
  
  ;; key binding
  (global-set-key "\M-}" 'tabbar-forward-tab)
  (global-set-key "\M-{" 'tabbar-backward-tab)
  )
 )
