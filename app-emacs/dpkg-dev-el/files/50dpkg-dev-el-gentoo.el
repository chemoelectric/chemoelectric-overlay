;; -*-emacs-lisp-*-
;;
;; Emacs startup file for the Debian GNU/Linux dpkg-dev-el package

(cond
 ((not (file-exists-p "@SITELISP@"))
  (message "Package dpkg-dev-el removed but not purged.  Skipping setup."))
 ((not (file-exists-p "@SITELISP@/readme-debian.elc"))
  (message "Package dpkg-dev-el not fully installed.  Skipping setup."))
 (t (add-to-list 'load-path "@SITELISP@")

    ;; (require 'dpkg-dev-el)

    ))
