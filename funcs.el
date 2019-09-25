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
;;;; jupter repl minor mode keymap
(spacemacs/set-leader-keys-for-minor-mode 'use-jupyter-repl-mode
  "'"  'jupyter-run-repl
  "cc" 'jupyter-load-file
  "cC" '(lambda (file) (interactive "f\file: ") (progn (jupyter-load-file file) (jupyter-repl-pop-to-buffer)))
  "sB" '(lambda () (interactive) (progn (jupyter-eval-buffer (current-buffer)) (jupyter-repl-pop-to-buffer)))
  "sb" 'jupyter-eval-buffer
  "sF" '(lambda () (interactive) (progn (jupyter-eval-defun) (jupyter-repl-pop-to-buffer)))
  "sf" 'jupyter-eval-defun
  "si" 'jupyter-run-repl
  "sR" '(lambda () (interactive) (progn (jupyter-eval-line-or-region 'null) (jupyter-repl-pop-to-buffer)))
  "sr" 'jupyter-eval-line-or-region)

;;;; jupyter repl minor mode
(defvar use-jupyter-repl-mode nil)

(define-minor-mode use-jupyter-repl-mode
  "Minor mode that will use a jupyter-repl from package
emacs-jupyter instead of the default repl.
Dependancies:
	emacs-jupyter package
	Jupyter kernel corresponding to the major-mode language.
		This needs to be installed on your system."
  :group 'jupyter-repl
  ;; :lighter "j-repl"
  :init-value nil
  (cond
   (use-jupyter-repl-mode
    (add-hook 'after-revert-hook 'use-jupyter-repl-mode nil t))
   (t
    (remove-hook 'after-revert-hook 'use-jupyter-repl-mode t))))

;;; funcs.el ends here
