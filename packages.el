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
    (jupyter :location (recipe :fetcher file :path "~/.spacemacs.d/emacs-jupyter"))
    ;; (jupyter :location local) 
    ;; jupyter
    smartparens
    websocket
    zmq
    ))
(defun jupyter/init-jupyter ()
  (if (executable-find "jupyter")
      (use-package jupyter
        :defer t
        :demand t
        :init
        (progn
          (spacemacs/set-leader-keys
            "aja" 'jupyter-repl-associate-buffer
            "ajc" 'jupyter-connect-repl
            "ajr" 'jupyter-run-repl
            "ajs" 'jupyter-server-list-kernels
            "ajt" 'use-jupyter-repl)
          (spacemacs/set-leader-keys-for-major-mode 'jupyter-repl-mode
            "i" 'jupyter-inspect-at-point
            "l" 'jupyter-load-file
            "s" 'jupyter-repl-scratch-buffer
            "I" 'jupyter-repl-interrupt-kernel
            "R" 'jupyter-repl-restart-kernel)
          (spacemacs/set-leader-keys-for-minor-mode 'use-jupyter-repl-mode
            "'"  'jupyter-run-repl
            "cc" 'jupyter-load-file
            "cC" '(lambda () (interactive) (use-jupyter-eval-pop 'jupyter-load-file))
            "sB" '(lambda () (interactive) (use-jupyter-eval-pop 'jupyter-eval-buffer))
            "sb" 'jupyter-eval-buffer
            "sF" '(lambda () (interactive) (use-jupyter-eval-pop 'jupyter-eval-defun))
            "sf" 'jupyter-eval-defun
            "si" 'jupyter-run-repl
            "sR" '(lambda () (interactive) (use-jupyter-eval-pop 'jupyter-eval-line-or-region))
            "sr" 'jupyter-eval-line-or-region)
          (when (eq dotspacemacs-editing-style 'vim)
            (evil-define-key '(insert normal) jupyter-repl-mode-map
              (kbd "C-j") 'jupyter-repl-history-next
              (kbd "C-k") 'jupyter-repl-history-previous
              ;; (kbd "C-l") 'jupyter-repl-clear-cells
              (kbd "M-j") 'jupyter-repl-forward-cell
              (kbd "M-k") 'jupyter-repl-backward-cell
              (kbd "C-s") 'jupyter-repl-scratch-buffer
              (kbd "C-R") 'isearch-forward
              (kbd "C-r") 'isearch-backward))))

    (message "jupyter was not found in your path, jupyter is not loaded")))

(defun jupyter/post-init-company ()
  (spacemacs|add-company-backends :backends company-capf :modes jupyter-repl-mode))

(defun jupyter/post-init-smartparens ()
  (add-hook 'jupyter-repl-mode-hook 'smartparens-mode))

(defun jupyter/init-websocket ()
  (use-package websocket
    :defer t))

(defun jupyter/init-zmq ()
  (use-package zmq
    :defer t))

;;; packages.el ends here
