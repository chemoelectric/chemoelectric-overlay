(module chalk ()
  (import scheme
          chicken.read-syntax)

  (set-read-syntax! #\@
    (lambda (in)
      (let ((expression (read in)))
        (if (list? expression)
            (values)
            expression)))))
