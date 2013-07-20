;; -*-emacs-lisp-*-
;;
;; Emacs startup file for the Debian GNU/Linux debian-el package

(cond
 ((not (file-exists-p "@SITELISP@"))
  (message "Package debian-el removed but not purged.  Skipping setup."))
 ((not (file-exists-p (concat "@SITELISP@/preseed.elc")))
  (message "Package debian-el not fully installed.  Skipping setup."))
 (t (add-to-list 'load-path "@SITELISP@")
    
    ;; (require 'debian-el)

    ))
