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
  '(zmq
    simple-httpd
    websocket
    (jupyter :location (recipe
                        :fetcher github
                        :repo "dzop/emacs-jupyter"))))

(defun jupyter/init-zmq ()
  (use-package zmq))

(defun jupyter/init-simple-httpd ()
  (use-package simple-httpd))

(defun jupyter/init-websocket ()
  (use-package websocket))

(defun jupyter/init-jupyter ()
  (use-package jupyter
    :defer t
    :init
    (spacemacs/set-leader-keys
      "ajr" 'jupyter-run-repl
      "ajc" 'jupyter-connect-repl)
    :config
    (evilified-state-evilify-map 'jupyter-repl-mode-map
      :mode jupyter-repl-mode)
    ))

;;; packages.el ends here
