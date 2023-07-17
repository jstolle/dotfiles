
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
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
	 (proto (if no-ssl "http" "https")))
    (when no-ssl
      (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
    ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
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

(use-package async                        :defer t)
(use-package dash                         :defer t)
(use-package deferred                     :defer t)
(use-package diminish                     :demand t)
(use-package ghub                         :defer t)
(use-package ghub+                        :defer t)
(use-package term-manager-indexed-mapping :defer t)

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

(use-package ace-mc
  :bind (("<C-m> h"   . ace-mc-add-multiple-cursors)
         ("<C-m> M-h" . ace-mc-add-single-cursor)))

(use-package aggressive-indent
  :diminish
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(use-package align
  :bind (("M-["   . align-code)
         ("C-c [" . align-regexp))
  :commands align
  :preface
  (defun align-code (beg end &optional arg)
    (interactive "rP")
    (if (null arg)
        (align beg end)
      (let ((end-mark (copy-marker end)))
        (indent-region beg end-mark nil)
        (align beg end-mark)))))

(use-package auto-yasnippet
  :after yasnippet
  :bind (("C-c y a" . aya-create)
         ("C-c y e" . aya-expand)
         ("C-c y o" . aya-open-line)))

(use-package avy
  :bind* ("C-." . avy-goto-char-timer)
  :config
  (avy-setup-default))

(use-package avy-zap
  :bind (("M-z" . avy-zap-to-char-dwim)
         ("M-Z" . avy-zap-up-to-char-dwim)))

(use-package change-inner
  :bind (("M-i"     . change-inner)
         ("M-o M-o" . change-outer)))

(use-package css-mode
  :mode "\\.css\\'")

(use-package csv-mode
  :mode "\\.csv\\'")

(use-package display-line-numbers-mode
  :defer t
  :config
  (global-display-line-numbers-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package flycheck
  :commands (flycheck-mode
             flycheck-next-error
             flycheck-previous-error)
  :init
  (dolist (where '((emacs-lisp-mode-hook . emacs-lisp-mode-map)
                   (haskell-mode-hook    . haskell-mode-map)
                   (js2-mode-hook        . js2-mode-map)
                   (c-mode-common-hook   . c-mode-base-map)))
    (add-hook (car where)
              `(lambda ()
                 (bind-key "M-n" #'flycheck-next-error ,(cdr where))
                 (bind-key "M-p" #'flycheck-previous-error ,(cdr where)))))
  :config
  (defalias 'show-error-at-point-soon
    'flycheck-show-error-at-point)

  (defun magnars/adjust-flycheck-automatic-syntax-eagerness ()
    "Adjust how often we check for errors based on if there are any.
  This lets us fix any errors as quickly as possible, but in a
  clean buffer we're an order of magnitude laxer about checking."
    (setq flycheck-idle-change-delay
          (if flycheck-current-errors 0.3 3.0)))

  ;; Each buffer gets its own idle-change-delay because of the
  ;; buffer-sensitive adjustment above.
  (make-variable-buffer-local 'flycheck-idle-change-delay)

  (add-hook 'flycheck-after-syntax-check-hook
            #'magnars/adjust-flycheck-automatic-syntax-eagerness)

  ;; Remove newline checks, since they would trigger an immediate check
  ;; when we want the idle-change-delay to be in effect while editing.
  (setq-default flycheck-check-syntax-automatically '(save
                                                      idle-change
                                                      mode-enabled))

  (defun flycheck-handle-idle-change ()
    "Handle an expired idle time since the last change.
  This is an overwritten version of the original
  flycheck-handle-idle-change, which removes the forced deferred.
  Timers should only trigger inbetween commands in a single
  threaded system and the forced deferred makes errors never show
  up before you execute another command."
    (flycheck-clear-idle-change-timer)
    (flycheck-buffer-automatically 'idle-change)))

(use-package focus
  :commands focus-mode)

(use-package free-keys
  :commands free-keys)

(use-package grep
  :bind (("M-s n" . find-name-dired)
         ("M-s F" . find-grep)
         ("M-s G" . grep)
         ("M-s d" . find-grep-dired)))

(use-package helm
  :defer t
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-i"   . helm-execute-persistent-action)
              ("C-z"   . helm-select-action)
              ("A-v"   . helm-previous-page))
  :config
  (helm-autoresize-mode 1))

(use-package helm-dash
  :commands helm-dash)

(use-package helm-descbinds
  :bind ("C-h b" . helm-descbinds)
  :init
  (fset 'describe-bindings 'helm-descbinds))

(use-package helm-describe-modes
  :after helm
  :bind ("C-h m" . helm-describe-modes))

(use-package js2-mode
  :mode (("\\.js\\'"          . js2-mode)))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix))
  :bind (:map magit-mode-map
              ("U" . magit-unstage-all)
              ("M-h") ("M-s") ("M-m") ("M-w"))
  :bind (:map magit-file-section-map ("<C-return>"))
  :bind (:map magit-hunk-section-map ("<C-return>"))
  :preface
  ;; History can be viewed with:
  ;; git log refs/snapshots/$(git symbolic-ref HEAD)
  (defun magit-monitor (&optional no-display)
    "Start git-monitor in the current directory."
    (interactive)
    (let* ((path (file-truename
                  (directory-file-name
                   (expand-file-name default-directory))))
           (name (format "*git-monitor: %s*"
                         (file-name-nondirectory path))))
      (unless (and (get-buffer name)
                   (with-current-buffer (get-buffer name)
                     (string= path (directory-file-name default-directory))))
        (with-current-buffer (get-buffer-create name)
          (cd path)
          (ignore-errors
            (start-process "*git-monitor*" (current-buffer)
                           "git-monitor" "-d" path))))))

  (defun magit-status-with-prefix ()
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'magit-status)))

  (defun endless/visit-pull-request-url ()
    "Visit the current branch's PR on Github."
    (interactive)
    (browse-url
     (format "ssh://git@github.com/%s/pull/new/%s"
             (replace-regexp-in-string
              "\\`.+github\\.com:\\(.+?\\)\\(\\.git\\)?\\'" "\\1"
              (magit-get "remote" (magit-get-remote) "url"))
             (magit-get-current-branch))))

  :hook (magit-mode . hl-line-mode)
  :config
  (use-package magit-commit
    :config
    (use-package git-commit))

  (use-package magit-files
    :config
    (global-magit-file-mode))

  (add-hook 'magit-status-mode-hook #'(lambda () (magit-monitor t)))

  (define-key magit-mode-map "G" #'endless/visit-pull-request-url)

  (eval-after-load 'magit-remote
    '(progn
       (magit-define-popup-action 'magit-fetch-popup
                                  ?f 'magit-get-remote #'magit-fetch-from-upstream ?u t)
       (magit-define-popup-action 'magit-pull-popup
                                  ?F 'magit-get-upstream-branch #'magit-pull-from-upstream ?u t)
       (magit-define-popup-action 'magit-push-popup
                                  ?P 'magit--push-current-to-upstream-desc
                                  #'magit-push-current-to-upstream ?u t))))

(use-package magit-popup
  :defer t)

(use-package magit-imerge
  ;; jww (2017-12-10): Need to configure.
  :disabled t
  :after magit)

(use-package magithub
  :after magit
  :config
  (magithub-feature-autoinject t)

  (require 'auth-source-pass)
  (defvar my-ghub-token-cache nil)

  (advice-add
   'ghub--token :around
   #'(lambda (orig-func host username package &optional nocreate forge)
       (or my-ghub-token-cache
           (setq my-ghub-token-cache
                 (funcall orig-func host username package nocreate forge))))))

(use-package magithub-completion
  :commands magithub-completion-enable)

(use-package markdown-mode
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdown-preview-mode
  :after markdown-mode
  :config
  (setq markdown-preview-stylesheets
        (list (concat "https://github.com/dmarcotte/github-markdown-preview/"
                      "blob/master/data/css/github.css"))))

(use-package multiple-cursors
  :after phi-search
  :defer 5

  ;; - Sometimes you end up with cursors outside of your view. You can scroll
  ;;   the screen to center on each cursor with `C-v` and `M-v`.
  ;;
  ;; - If you get out of multiple-cursors-mode and yank - it will yank only
  ;;   from the kill-ring of main cursor. To yank from the kill-rings of every
  ;;   cursor use yank-rectangle, normally found at C-x r y.

  :bind (("<C-m> ^"     . mc/edit-beginnings-of-lines)
         ("<C-m> `"     . mc/edit-beginnings-of-lines)
         ("<C-m> $"     . mc/edit-ends-of-lines)
         ("<C-m> '"     . mc/edit-ends-of-lines)
         ("<C-m> R"     . mc/reverse-regions)
         ("<C-m> S"     . mc/sort-regions)
         ("<C-m> W"     . mc/mark-all-words-like-this)
         ("<C-m> Y"     . mc/mark-all-symbols-like-this)
         ("<C-m> a"     . mc/mark-all-like-this-dwim)
         ("<C-m> c"     . mc/mark-all-dwim)
         ("<C-m> l"     . mc/insert-letters)
         ("<C-m> n"     . mc/insert-numbers)
         ("<C-m> r"     . mc/mark-all-in-region)
         ("<C-m> s"     . set-rectangular-region-anchor)
         ("<C-m> %"     . mc/mark-all-in-region-regexp)
         ("<C-m> t"     . mc/mark-sgml-tag-pair)
         ("<C-m> w"     . mc/mark-next-like-this-word)
         ("<C-m> x"     . mc/mark-more-like-this-extended)
         ("<C-m> y"     . mc/mark-next-like-this-symbol)
         ("<C-m> C-x"   . reactivate-mark)
         ("<C-m> C-SPC" . mc/mark-pop)
         ("<C-m> ("     . mc/mark-all-symbols-like-this-in-defun)
         ("<C-m> C-("   . mc/mark-all-words-like-this-in-defun)
         ("<C-m> M-("   . mc/mark-all-like-this-in-defun)
         ("<C-m> ["     . mc/vertical-align-with-space)
         ("<C-m> {"     . mc/vertical-align)

         ("S-<down-mouse-1>")
         ("S-<mouse-1>" . mc/add-cursor-on-click))

  :bind (:map selected-keymap
              ("c"   . mc/edit-lines)
              ("."   . mc/mark-next-like-this)
              ("<"   . mc/unmark-next-like-this)
              ("C->" . mc/skip-to-next-like-this)
              (","   . mc/mark-previous-like-this)
              (">"   . mc/unmark-previous-like-this)
              ("C-<" . mc/skip-to-previous-like-this)
              ("y"   . mc/mark-next-symbol-like-this)
              ("Y"   . mc/mark-previous-symbol-like-this)
              ("w"   . mc/mark-next-word-like-this)
              ("W"   . mc/mark-previous-word-like-this))

  :preface
  (defun reactivate-mark ()
    (interactive)
    (activate-mark)))

(use-package multi-term
  :bind (("C-c t" . multi-term-next)
         ("C-c T" . multi-term))
  :init
  (defun screen ()
    (interactive)
    (let (term-buffer)
      ;; Set buffer.
      (setq term-buffer
            (let ((multi-term-program (executable-find "screen"))
                  (multi-term-program-switches "-DR"))
              (multi-term-get-buffer)))
      (set-buffer term-buffer)
      (multi-term-internal)
      (switch-to-buffer term-buffer)))

  :config
  (require 'term)

  (defalias 'my-term-send-raw-at-prompt 'term-send-raw)

  (defun my-term-end-of-buffer ()
    (interactive)
    (call-interactively #'end-of-buffer)
    (if (and (eobp) (bolp))
        (delete-char -1)))

  (defadvice term-process-pager (after term-process-rebind-keys activate)
    (define-key term-pager-break-map  "\177" 'term-pager-back-page)))

(use-package persistent-scratch
  :unless (or (null window-system)
              noninteractive)
  :defer 5
  :config
  (persistent-scratch-autosave-mode)
  (with-demoted-errors "Error: %S"
    (persistent-scratch-setup-default))
  :commands persistent-scratch-setup-default)

(use-package phi-search
  :defer 5)

(use-package phi-search-mc
  :after (phi-search multiple-cursors)
  :config
  (phi-search-mc/setup-keys)
  (add-hook 'isearch-mode-mode #'phi-search-from-isearch-mc/setup-keys))

(use-package projectile
  :defer 5
  :diminish
  :bind* (("C-c TAB" . projectile-find-other-file)
          ("C-c P" . (lambda () (interactive)
                       (projectile-cleanup-known-projects)
                       (projectile-discover-projects-in-search-path))))
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)

  (defun my-projectile-invalidate-cache (&rest _args)
    ;; We ignore the args to `magit-checkout'.
    (projectile-invalidate-cache nil))

  (eval-after-load 'magit-branch
    '(progn
       (advice-add 'magit-checkout
                   :after #'my-projectile-invalidate-cache)
       (advice-add 'magit-branch-and-checkout
                   :after #'my-projectile-invalidate-cache))))


(use-package yasnippet
  :demand t
  :diminish yas-minor-mode
  :bind (("C-c y d" . yas-load-directory)
         ("C-c y i" . yas-insert-snippet)
         ("C-c y f" . yas-visit-snippet-file)
         ("C-c y n" . yas-new-snippet)
         ("C-c y t" . yas-tryout-snippet)
         ("C-c y l" . yas-describe-tables)
         ("C-c y g" . yas/global-mode)
         ("C-c y m" . yas/minor-mode)
         ("C-c y r" . yas-reload-all)
         ("C-c y x" . yas-expand))
  :bind (:map yas-keymap
              ("C-i" . yas-next-field-or-maybe-expand))
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :config
  (yas-load-directory (emacs-path "snippets"))
  (yas-global-mode 1))

;;; Layout
(load-theme 'zenburn t)

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
