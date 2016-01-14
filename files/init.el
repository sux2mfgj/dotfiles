;; -*- tab-width: 4; coding: utf-8; lexical-binding:t  -*-

(cond
 ((>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (package-refresh-contents)
  
  (unless (package-installed-p 'init-loader)
	(package-install init-loader))

    (require 'init-loader)
  (init-loader-load "~/.emacs.d/inits")
  )
 (t
  (message "don't load init.el. please use emase 24 or later"))
  )
 
