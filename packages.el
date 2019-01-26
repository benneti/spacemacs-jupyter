;;; packages.el --- jupyter layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Benedikt Tissot <benneti@bennetis-xps>
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
    (emacs-jupyter :location (recipe
                              :fetcher github
                              :repo "dzop/emacs-jupyter"))))

(defun jupyter/init-zmq ()
  (use-package zmq
    :defer t
    :ensure nil))

(defun jupyter/init-simple-httpd ()
  (use-package simple-httpd
    :defer t
    :ensure nil))

(defun jupyter/init-websocket ()
  (use-package websocket
    :defer t
    :ensure nil))

(defun jupyter/init-emacs-jupyter ()
  (use-package emacs-jupyter
    :defer t
    :ensure nil
    :after '(emacs-zmq websocket simple-httpd)))

;;; packages.el ends here
