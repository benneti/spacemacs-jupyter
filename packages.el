;;; packages.el --- jupyter layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Benedikt Tissot <benedikt.tissot@googlemail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `jupyter-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `jupyter/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `jupyter/pre-init-PACKAGE' and/or
;;   `jupyter/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst jupyter-packages
  '(
    company
    jupyter
    ))

(defun jupyter/init-jupyter ()
  (if (executable-find "jupyter")
      (use-package jupyter
        :defer t
        :init
        (progn
          (spacemacs/declare-prefix "aj" "jupyter")
          (spacemacs/declare-prefix "ajo" "org-jupyter")
          (spacemacs/set-leader-keys
            "aja" 'jupyter-repl-associate-buffer
            "ajc" 'jupyter-connect-repl
            "ajr" 'jupyter-run-repl
            "ajoo" 'jupyter/override-src-block-lang
            "ajoO" 'jupyter/override-all-src-block-lang
            "ajor" 'jupyter/restore-src-block-lang
            "ajoR" 'jupyter/restore-all-src-block-lang
            "ajos" 'org-babel-jupyter-scratch-buffer
            "ajs" 'jupyter-server-list-kernels
            )
          (spacemacs/set-leader-keys-for-major-mode 'jupyter-repl-mode
            "i" 'jupyter-inspect-at-point
            "l" 'jupyter-load-file
            "s" 'jupyter-repl-scratch-buffer
            "I" 'jupyter-repl-interrupt-kernel
            "R" 'jupyter-repl-restart-kernel))
        :config
        (progn
          (when (eq dotspacemacs-editing-style 'vim)
            (evil-define-key '(insert normal) jupyter-repl-mode-map
              (kbd "C-j") 'jupyter-repl-history-next
              (kbd "C-k") 'jupyter-repl-history-previous
              (kbd "C-l") 'jupyter-repl-clear-cells
              (kbd "M-j") 'jupyter-repl-forward-cell
              (kbd "M-k") 'jupyter-repl-backward-cell
              (kbd "C-s") 'jupyter-repl-scratch-buffer
              (kbd "C-R") 'isearch-forward
              (kbd "C-r") 'isearch-backward))))

    (message "jupyter was not found in your path, jupyter is not loaded")))

(defun jupyter/post-init-company ()
  (spacemacs|add-company-backends :backends company-capf :modes jupyter-repl-mode))


(defun jupyter/override-src-block-lang ()
  "Apply org-babel-jupyter-override-src-block to the selected language "
  (interactive)
  (let ((lang (read-string "Override Language: ")))
    (org-babel-jupyter-override-src-block lang)))

(defun jupyter/restore-src-block-lang ()
  "Apply org-babel-jupyter-restore-src-block to the selected language "
  (interactive)
  (let ((lang (read-string "Restore Language: ")))
    (org-babel-jupyter-restore-src-block lang)))

;; TODO these won't work. kernel name is not the same as babel language name
;; need some table to match kernel-name to babel lang name
;; also maybe define new babel langs based on kernels
(defun jupyter/override-all-src-block-lang ()
  "Apply org-babel-jupyter-override-src-block to all languages of
installed kernels."
  (interactive)
  (let ((langs (mapcar 'car (jupyter-available-kernelspecs))))
    (mapc 'org-babel-jupyter-override-src-block langs)))

(defun jupyter/restore-all-src-block-lang ()
  "Restore all babel languages overridden by jupyter/override-all-src-block-lang"
  (interactive)
  (let ((langs (mapcar 'car (jupyter-available-kernelspecs))))
    (mapc 'org-babel-jupyter-restore-src-block langs)))


;;; packages.el ends here
