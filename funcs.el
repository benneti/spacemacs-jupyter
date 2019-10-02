(defun jupyter/ox-ipynb-emacs-jupyter ()
    (cl-loop
       for (kernel . (_dir . spec)) in (jupyter-available-kernelspecs)
       for lang = (plist-get spec :language)
       for display-name = (plist-get spec :display_name)
       do (cl-pushnew (cons (intern (concat "jupyter-" lang))
                            (cons (intern "kernelspec") (list
                                                         (cons (intern "display_name") display-name)
                                                         (cons (intern "language") lang)
                                                         (cons (intern "name") kernel)
                                                         )))
                      ox-ipynb-kernelspecs :test #'equal))

      (cl-loop
       for (kernel . (_dir . spec)) in (jupyter-available-kernelspecs)
       for lang = (plist-get spec :language)
       for display-name = (plist-get spec :display_name)
       do (cl-pushnew (cons (intern (concat "jupyter-" lang))
                            (cons (intern "language_info") (list
                                                            (cons (intern "name") lang)
                                                            (cons (intern "version") (nth 1 (split-string display-name)))
                                                            )))
                      ox-ipynb-language-infos :test #'equal)))
