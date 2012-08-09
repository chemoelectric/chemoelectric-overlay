(autoload 'exheres-mode "exheres-mode" "Major mode for editing files in exheres format" t)
(autoload 'exlib-mode "exheres-mode" "Major mode for editing files in exlib format" t)
(autoload 'eclectic-mode "eclectic-mode" "Major mode for editing files in eclectic format" t)

(add-to-list 'auto-mode-alist '("\\.eclectic\\'" . eclectic-mode))
(add-to-list 'auto-mode-alist '("\\.exheres-0\\'" . exheres-mode))
(add-to-list 'auto-mode-alist '("\\.exlib\\'" . exlib-mode))
