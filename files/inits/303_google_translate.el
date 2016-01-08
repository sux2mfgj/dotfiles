;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

(package-load-with-check
 google-translate
 ((global-set-key "\C-xt" 'google-translate-at-point)
  (global-set-key "\C-Xt" 'google-translate-query-translate)
  (custom-set-variables
   '(google-translate-default-source-language "ja")
   '(google-translate-default-target-language "en"))
  (push '("*Google Translate*") popwin:special-display-config)
  )
 )
