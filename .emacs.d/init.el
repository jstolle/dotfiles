
(defconst emacs-start-time (current-time))

(defvar file-name-handler-alist-old file-name-handler-alist)

(setq package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      auto-window-vscroll nil)

(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;;; MELPA Initialization

(eval-and-compile
  (require 'package)
  (package-initialize))

;;; Functions

(eval-and-compile
  (defun emacs-path (path)
    (expand-file-name path user-emacs-directory))

  (defun lookup-password (host user port)
    (require 'auth-source)
    (require 'auth-source-pass)
    (let ((auth (auth-source-search :host host :user user :port port)))
      (if auth
          (let ((secretf (plist-get (car auth) :secret)))
            (if secretf
                (funcall secretf)
              (error "Auth entry for %s@%s:%s has no secret!"
                     user host port)))
        (error "No auth entry found for %s@%s:%s" user host port))))

  (defvar saved-window-configuration nil)

  (defun push-window-configuration ()
    (interactive)
    (push (current-window-configuration) saved-window-configuration))

  (defun pop-window-configuration ()
    (interactive)
    (let ((config (pop saved-window-configuration)))
      (if config
          (set-window-configuration config)
        (if (> (length (window-list)) 1)
            (delete-window)
          (bury-buffer)))))

;;; Environment

  (setq load-path
        (append '("~/.emacs.d")
                (delete-dups load-path)
                '("~/.emacs.d/lisp")))

  (defun filter (f args)
    (let (result)
      (dolist (arg args)
        (when (funcall f arg)
          (setq result (cons arg result))))
      (nreverse result)))

  (require 'use-package)

  (defconst load-path-reject-re "/\\.emacs\\.d/\\(lib\\|site-lisp\\)/"
    "Regexp matching `:load-path' values to be rejected.")

  (defun load-path-handler-override (orig-func name keyword args rest state)
    (if (cl-some (apply-partially #'string-match load-path-reject-re) args)
        (use-package-process-keywords name rest state)
      (let ((body (use-package-process-keywords name rest state)))
        (use-package-concat
         (mapcar #'(lambda (path)
                     `(eval-and-compile (add-to-list 'load-path ,path t)))
                 args)
         body))))

  (advice-add 'use-package-handler/:load-path
              :around #'load-path-handler-override)

  (if init-file-debug
      (setq use-package-verbose t
            use-package-expand-minimally nil
            use-package-compute-statistics t
            debug-on-error t)
    (setq use-package-verbose nil
          use-package-expand-minimally t)))

;;; Settings

(eval-and-compile
  (defconst emacs-data-suffix nil)
  
  (defconst user-data-directory
    (emacs-path "data"))

  (load (emacs-path "settings"))

  ;; Note that deferred loading may override some of these changed values.
  ;; This can happen with `savehist', for example.
  (when emacs-data-suffix
    (let ((settings (with-temp-buffer
                      (insert-file-contents (emacs-path "settings.el"))
                      (read (current-buffer)))))
      (pcase-dolist (`(quote (,var ,value . ,_)) (cdr settings))
        (when (and (stringp value)
                   (string-match "/\\.emacs\\.d/data" value))
          (set var (replace-regexp-in-string
                    "/\\.emacs\\.d/data"
                    (format "/.emacs.d/data-%s" emacs-data-suffix)
                    value)))))))

(defvar Info-directory-list
  (mapcar 'expand-file-name
          (append
           '("~/.local/share/info"))))

(setq disabled-command-function nil) ;; enable all commands

(eval-when-compile
  ;; Disable all warnings about obsolete functions here.
  (dolist (sym '(flet lisp-complete-symbol))
    (setplist sym (use-package-plist-delete (symbol-plist sym)
                                            'byte-obsolete-info))))

;;; Libraries


;;; Keymaps

(define-key input-decode-map [?\C-m] [C-m])

(eval-and-compile
  (mapc #'(lambda (entry)
            (define-prefix-command (cdr entry))
            (bind-key (car entry) (cdr entry)))
        '(("C-,"   . my-ctrl-comma-map)
          ("<C-m>" . my-ctrl-m-map)

          ("C-h e" . my-ctrl-h-e-map)
          ("C-h x" . my-ctrl-h-x-map)

          ("C-c b" . my-ctrl-c-b-map)
          ("C-c e" . my-ctrl-c-e-map)
          ("C-c m" . my-ctrl-c-m-map)
          ("C-c w" . my-ctrl-c-w-map)
          ("C-c y" . my-ctrl-c-y-map)
          ("C-c H" . my-ctrl-c-H-map)
          ("C-c N" . my-ctrl-c-N-map)
          ("C-c (" . my-ctrl-c-open-paren-map)
          ("C-c -" . my-ctrl-c-minus-map)
          ("C-c =" . my-ctrl-c-equals-map)
          ("C-c ." . my-ctrl-c-r-map)
          )))

;;; Packages

(use-package all-the-icons
  :ensure t
  :defer t
  :hook (after-init . all-the-icons-install-fonts))

;; (use-package doom-modeline
;;   :after all-the-icons
;;   :ensure t
;;   :defer t
;;   :hook (after-init . doom-modeline-init))

;; (use-package doom-themes
;;   :if window-system
;;   :ensure t
;;   :defer t
;;   :hook (after-init . ((load-theme doom-theme-name t)
;;                        (doom-themes-visual-bell-config)
;;                        (doom-themes-treemacs-config)
;;                        (doom-themes-org-config))))

(use-package smart-newline
  :diminish
  :commands smart-newline-mode)

(use-package smart-region
  :disabled t
  :bind ("S-SPC" . smart-region))

(use-package smartparens-config
  :commands smartparens-mode)

(use-package smartscan
  :defer 5
  :bind (:map smartscan-map
              ("C->" . smartscan-symbol-go-forward)
              ("C-<" . smartscan-symbol-go-backward)))

(use-package smedl-mode
  :load-path "~/bae/micromht-fiat-deliverable/atif-monitors/smon/smedl/emacs"
  :mode "\\.\\(a4\\)?smedl\\'")

(use-package smerge-mode
  :commands smerge-mode)

(use-package smex
  :defer 5
  :commands smex)

(use-package sort-words
  :commands sort-words)

(use-package sos
  :commands sos)

(use-package sql-indent
  :commands sqlind-minor-mode)

(use-package stopwatch
  :bind ("<f8>" . stopwatch))

(use-package string-edit
  :bind ("C-c C-'" . string-edit-at-point))

(use-package string-inflection
  :bind ("C-c `" . string-inflection-all-cycle))

(use-package super-save
  :diminish
  :commands super-save-mode
  :config
  (setq super-save-auto-save-when-idle t))

(use-package tidy
  :commands (tidy-buffer
             tidy-parse-config-file
             tidy-save-settings
             tidy-describe-options))

(use-package treemacs
  :commands treemacs)

(use-package typo
  :commands typo-mode)

(use-package vdiff
  :commands (vdiff-files
             vdiff-files3
             vdiff-buffers
             vdiff-buffers3))

(use-package vimish-fold
  :bind (("C-c V f" . vimish-fold)
         ("C-c V d" . vimish-fold-delete)
         ("C-c V D" . vimish-fold-delete-all)))

(use-package visual-fill-column
  :commands visual-fill-column-mode)

(use-package visual-regexp
  :bind (("C-c r"   . vr/replace)
         ("C-c %"   . vr/query-replace)
         ("<C-m> /" . vr/mc-mark)))

(use-package visual-regexp-steroids
  ;; jww (2017-12-10): I prefer to use Emacs regexps within Emacs.
  :disabled t
  :after visual-regexp)

(use-package vline
  :commands vline-mode)

(use-package web-mode
  :commands web-mode)

(use-package wgrep
  :defer 5)

(use-package which-key
  :defer 5
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode))

(use-package whitespace
  :diminish (global-whitespace-mode
             whitespace-mode
             whitespace-newline-mode)
  :commands (whitespace-buffer
             whitespace-cleanup
             whitespace-mode
             whitespace-turn-off)
  :preface
  (defvar normalize-hook nil)

  (defun normalize-file ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (whitespace-cleanup)
      (run-hook-with-args normalize-hook)
      (delete-trailing-whitespace)
      (goto-char (point-max))
      (delete-blank-lines)
      (set-buffer-file-coding-system 'unix)
      (goto-char (point-min))
      (while (re-search-forward "\r$" nil t)
        (replace-match ""))
      (set-buffer-file-coding-system 'utf-8)
      (let ((require-final-newline t))
        (save-buffer))))

  (defun maybe-turn-on-whitespace ()
    "depending on the file, maybe clean up whitespace."
    (when (and (not (or (memq major-mode '(markdown-mode))
                        (and buffer-file-name
                             (string-match "\\(\\.texi\\|COMMIT_EDITMSG\\)\\'"
                                           buffer-file-name))))
               (locate-dominating-file default-directory ".clean")
               (not (locate-dominating-file default-directory ".noclean")))
      (whitespace-mode 1)
      ;; For some reason, having these in settings.el gets ignored if
      ;; whitespace loads lazily.
      (setq whitespace-auto-cleanup t
            whitespace-line-column 80
            whitespace-rescan-timer-time nil
            whitespace-silent t
            whitespace-style '(face trailing lines space-before-tab empty))
      (add-hook 'write-contents-hooks
                #'(lambda () (ignore (whitespace-cleanup))) nil t)
      (whitespace-cleanup)))

  :init
  (add-hook 'find-file-hooks 'maybe-turn-on-whitespace t)

  :config
  (remove-hook 'find-file-hooks 'whitespace-buffer)
  (remove-hook 'kill-buffer-hook 'whitespace-buffer))

(use-package whitespace-cleanup-mode
  :defer 5
  :diminish
  :commands whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode 1))

(use-package whole-line-or-region
  :disabled t
  :unless noninteractive
  :defer 5
  :diminish whole-line-or-region-local-mode
  :config
  (whole-line-or-region-global-mode 1))

(use-package window-purpose
  :commands purpose-mode)

(use-package winner
  :unless noninteractive
  :defer 5
  :bind (("M-N" . winner-redo)
         ("M-P" . winner-undo))
  :config
  (winner-mode 1))

(use-package word-count
  :bind ("C-c \"" . word-count-mode))

(use-package x86-lookup
  :bind ("C-h X" . x86-lookup))

(use-package xray
  :bind (("C-h x b" . xray-buffer)
         ("C-h x f" . xray-faces)
         ("C-h x F" . xray-features)
         ("C-h x R" . xray-frame)
         ("C-h x h" . xray-hooks)
         ("C-h x m" . xray-marker)
         ("C-h x o" . xray-overlay)
         ("C-h x p" . xray-position)
         ("C-h x S" . xray-screen)
         ("C-h x s" . xray-symbol)
         ("C-h x w" . xray-window)))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

;; (use-package yasnippet
;;   :demand t
;;   :diminish yas-minor-mode
;;   :bind (("C-c y d" . yas-load-directory)
;;          ("C-c y i" . yas-insert-snippet)
;;          ("C-c y f" . yas-visit-snippet-file)
;;          ("C-c y n" . yas-new-snippet)
;;          ("C-c y t" . yas-tryout-snippet)
;;          ("C-c y l" . yas-describe-tables)
;;          ("C-c y g" . yas/global-mode)
;;          ("C-c y m" . yas/minor-mode)
;;          ("C-c y r" . yas-reload-all)
;;          ("C-c y x" . yas-expand))
;;   :bind (:map yas-keymap
;;               ("C-i" . yas-next-field-or-maybe-expand))
;;   :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
;;   :config
;;   (yas-load-directory (emacs-path "snippets"))
;;   (yas-global-mode 1))

(use-package zoom
  :bind ("C-x +" . zoom)
  :preface
  (defun size-callback ()
    (cond ((> (frame-pixel-width) 1280) '(90 . 0.75))
          (t '(0.5 . 0.5)))))

(use-package ztree-diff
  :commands ztree-diff)

;;; Layout
(load-theme 'solarized t)

;;; Finalization

(let ((elapsed (float-time (time-subtract (current-time)
                                          emacs-start-time))))
  (message "Loading %s...done (%.3fs)" load-file-name elapsed))

(add-hook 'after-init-hook
          `(lambda ()
             (let ((elapsed
                    (float-time
                     (time-subtract (current-time) emacs-start-time))))
               (message "Loading %s...done (%.3fs) [after-init]"
                        ,load-file-name elapsed))) t)

(defun startup ()
  (interactive))

;;; init.el ends here
