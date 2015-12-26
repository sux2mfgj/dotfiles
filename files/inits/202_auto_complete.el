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
  )
 )


