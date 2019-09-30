;;; funcs.el --- jupyter layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Benedikt Tissot <benedikt.tissot@googlemail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

;;;; jupyter repl minor mode
;; (defvar use-jupyter-repl-mode nil)

(define-minor-mode use-jupyter-repl-mode
  "Minor mode that will use a jupyter-repl from package
emacs-jupyter instead of the default repl.
Dependancies:
	emacs-jupyter package
	Jupyter kernel corresponding to the major-mode language.
		This needs to be installed on your system."
  :group 'jupyter-repl
  :lighter "j-repl"
  :init-value nil
  (cond
   (use-jupyter-repl-mode
    (add-hook 'after-revert-hook 'use-jupyter-repl-mode nil t))
   (t
    (remove-hook 'after-revert-hook 'use-jupyter-repl-mode t))))

;;;; use-jupyter-repl 
(defun use-jupyter-repl ()
  "Checks whether a jupyter repl kernel is associated with this buffer.
If there is, then set repl keybindings to use it. Otherwise, associate the
buffer with a repl. If no repl is running for the major-mode, ask to start one."
  (interactive)
  (if (eq jupyter-current-client nil)
      (call-interactively 'jupyter-repl-associate-buffer)
    (call-interactively 'use-jupyter-repl-mode)))

;;;; use-jupyter-eval-pop
(defun use-jupyter-eval-pop (func &rest args)
  (interactive)
  (call-interactively func 'args)
  (jupyter-repl-pop-to-buffer))

;;; funcs.el ends here
