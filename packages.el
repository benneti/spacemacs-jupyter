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
  '(jupyter))

(defun jupyter/init-jupyter ()
  (if (executable-find "jupyter")
      (use-package jupyter
        :defer t
        :init
        (spacemacs/set-leader-keys
          ;; TODO optimally this should behave like when called from helm
          "ajr" 'jupyter-run-repl
          "ajc" 'jupyter-connect-repl)
        :config
        (progn
          (evilified-state-evilify-map 'jupyter-repl-mode-map
            :mode jupyter-repl-mode)

          ;; TODO is this necessary?
          (defun spacemacs//concat-leader (key)
            (if dotspacemacs-major-mode-leader-key
                (concat dotspacemacs-major-mode-leader-key key)
              (concat "," key)))

          ;; TODO not working
          (spacemacs/set-leader-keys-for-major-mode 'jupyter-repl-mode
            "," 'jupyter-eval-line-or-region
            "ee" 'jupyter-eval-line-or-region
            "ed" 'jupyter-eval-defun
            "eb" 'jupyter-eval-buffer
            "fl" 'jupyter-load-file
            "fs" 'jupyter-repl-scratch-buffer
            "fb" 'jupyter-repl-pop-to-buffer
            "kr" 'jupyter-repl-restart-kernel
            "hn"  'jupyter-repl-history-next
            "hN"  'jupyter-repl-history-previous
            "i" 'jupyter-inspect-at-point
            "sb" 'jupyter-repl-pop-to-buffer)))
    (message "jupyter was not found on your path, scimax patches from scimax were not loaded")))

;;; packages.el ends here
