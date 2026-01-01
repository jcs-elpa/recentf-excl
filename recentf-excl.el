;;; recentf-excl.el --- Exclude commands for recent files  -*- lexical-binding: t; -*-

;; Copyright (C) 2022-2026  Shen, Jen-Chieh
;; Created date 2022-05-23 19:01:51

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs-elpa/recentf-excl
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (msgu "0.1.0"))
;; Keywords: convenience excl exclude recentf

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Exclude commands for recent files
;;

;;; Code:

(require 'msgu)

(defgroup recentf-excl nil
  "Exclude commands for recent files."
  :prefix "recentf-excl-"
  :group 'convenience
  :group 'tools
  :link '(url-link :tag "Repository" "https://github.com/jcs-elpa/recentf-excl"))

(defcustom recentf-excl-commands nil
  "List of commands to ignore recent files."
  :type 'list
  :group 'recentf-excl)

;;;###autoload
(defvar recentf-excl-tracking-p t
  "If non-nil, track the opened file.")

;;
;;; Util

(defun recentf-excl--re-enable-mode (modename)
  "Re-enable the MODENAME."
  (msgu-silent
    (funcall-interactively modename -1) (funcall-interactively modename 1)))

(defun recentf-excl--re-enable-mode-if-was-enabled (modename)
  "Re-enable the MODENAME if was enabled."
  (when (boundp modename)
    (when (symbol-value modename) (recentf-excl--re-enable-mode modename))
    (symbol-value modename)))

(defun recentf-excl--listify (obj)
  "Turn OBJ to list."
  (if (listp obj) obj (list obj)))

;;
;;; Core

;;;###autoload
(defmacro recentf-excl-it (&rest body)
  "Execute BODY and ignore recent files."
  (declare (indent 0) (debug t))
  `(let (recentf-excl-tracking-p) ,@body))

(defun recentf-excl--adv-around (fnc &rest args)
  "Advice bind FNC and ARGS."
  (recentf-excl-it (apply fnc args)))

(defun recentf-excl--track-opened-file (fnc &rest args)
  "Control of track opened file.

Advice arguments FNC and ARGS."
  (when recentf-excl-tracking-p (apply fnc args)))

(defun recentf-excl-mode--enable ()
  "Enable function `recentf-excl-mode'."
  (advice-add 'recentf-track-opened-file :around #'recentf-excl--track-opened-file)
  (dolist (command recentf-excl-commands)
    (advice-add command :around #'recentf-excl--adv-around)))

(defun recentf-excl-mode--disable ()
  "Disable function `recentf-excl-mode'."
  (advice-remove 'recentf-track-opened-file #'recentf-excl--track-opened-file)
  (dolist (command recentf-excl-commands)
    (advice-remove command #'recentf-excl--adv-around)))

;;;###autoload
(define-minor-mode recentf-excl-mode
  "Minor mode `recentf-excl-mode'."
  :global t
  :require 'recentf-excl-mode
  :group 'recentf-excl
  (if recentf-excl-mode (recentf-excl-mode--enable) (recentf-excl-mode--disable)))

;;
;;; Users

;;;###autoload
(defun recentf-excl-add-commands (command)
  "Add COMMAND to exclude list."
  (let ((commands (recentf-excl--listify command)))
    (nconc recentf-excl-commands commands)
    (recentf-excl--re-enable-mode-if-was-enabled #'recentf-excl-mode)))

(provide 'recentf-excl)
;;; recentf-excl.el ends here
